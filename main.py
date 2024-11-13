from flask import Flask, render_template, request, redirect, session, make_response, jsonify, url_for, send_file
from flask_sqlalchemy import SQLAlchemy
from googleapiclient.discovery import build
import re
import emoji
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
import matplotlib
from datetime import datetime
from io import BytesIO
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from reportlab.lib.utils import ImageReader
import os

matplotlib.use('Agg')  
import matplotlib.pyplot as plt

app = Flask(__name__)
API_KEY = 'Your API key' 
youtube = build('youtube', 'v3', developerKey=API_KEY)

app.secret_key = "moodtube_secret_key"
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@localhost/moodtube'





db = SQLAlchemy(app)


class User_account(db.Model):
    user_id = db.Column(db.Integer, primary_key=True)
    user_name = db.Column(db.String(20), nullable=False)
    email = db.Column(db.String(20), nullable=False)
    password = db.Column(db.String(20), nullable=False)


class Sentimentanalysisresult(db.Model):
    search_id = db.Column(db.Integer, primary_key=True)
    video_id = db.Column(db.String(200), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user_account.user_id'))
    profileImage = db.Column(db.String(150), nullable=True)
    total_subscriber = db.Column(db.String(10), nullable=True)
    video_title = db.Column(db.String(200), nullable=True)
    channel_name = db.Column(db.String(100), nullable=True)
    total_comments = db.Column(db.Integer, nullable=True)
    rComment1 = db.Column(db.String(1000), nullable=True)
    rComment2 = db.Column(db.String(1000), nullable=True)
    rComment3 = db.Column(db.String(1000), nullable=True)
    rComment4 = db.Column(db.String(1000), nullable=True)
    rComment5 = db.Column(db.String(1000), nullable=True)
    positive_comments = db.Column(db.String(1000), nullable=True)
    negative_comments = db.Column(db.String(1000), nullable=True)
    overall_sentiment = db.Column(db.String(200), nullable=True)
    pi_chart = db.Column(db.String(200), nullable=True)
    bar_chart = db.Column(db.String(200), nullable=True)
    date = db.Column(db.String(12), nullable=True)

    # user = db.relationship('User_account')

    def to_dict(self):
        return {
            "user_id": self.user_id,
            "user_name": self.user_name,
            "email": self.email,
        }


@app.route("/")
def home():
    return render_template('index.html')


@app.route("/search", methods=['GET', 'POST'])
def search():
    if request.method == "POST":

        # Get the search term
        search_term = request.form.get('search')

        return redirect(url_for('dashboard'))  

    return render_template('search_url.html')


@app.route("/signup", methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        user_name = request.form.get('username')
        email = request.form.get('email')
        password = request.form.get('password')

        
        existing_user = User_account.query.filter_by(email=email).first()
        if existing_user:
            return jsonify({"error": "User already exists"}), 400

        entry = User_account(user_name=user_name, email=email, password=password)
        db.session.add(entry)
        db.session.commit()

    return render_template('login_signup.html')


@app.route("/login", methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        login_credential = request.form.get('email_username')
        password = request.form.get('password')
        remember = request.form.get('remember')  # Check if Remember Me is checked

        user = User_account.query.filter(
            (User_account.email == login_credential) | (User_account.user_name == login_credential)
        ).filter_by(password=password).first()

        if user:
            # Handle user session
            session['user_id'] = user.user_id
            session['user_name'] = user.user_name

            # If Remember Me is checked
            if remember:
                resp = make_response(redirect('/history'))
                resp.set_cookie('user_id', str(user.user_id), max_age=30 * 24 * 60 * 60)  # 30 days
                return resp

            return redirect('/history')  # Redirect without remember me

        else:
            return jsonify({"error": "Invalid login credentials"}), 401

    return render_template('login_signup.html')


@app.route('/analyze', methods=['GET', 'POST'])
def analyze():
    url = request.form.get('url')
    video_id_match = re.search(r'(?:v=|\/)([\w-]{11})', url)

    if not video_id_match:
        return jsonify({'error': 'Invalid URL'}), 400

    video_id = video_id_match.group(1)

    try:
        # Fetching video details
        video_response = youtube.videos().list(part='snippet,statistics', id=video_id).execute()
        if not video_response['items']:
            return jsonify({'error': 'No video found'}), 404

        video_snippet = video_response['items'][0]['snippet']
        video_stats = video_response['items'][0]['statistics']
        video_title = video_snippet['title']
        channel_name = video_snippet['channelTitle']
        total_comments = video_stats.get('commentCount', '0')
        channel_id = video_snippet['channelId']

        # Fetching channel details
        channel_response = youtube.channels().list(part='snippet,statistics', id=channel_id).execute()
        if not channel_response['items']:
            return jsonify({'error': 'No channel found'}), 404

        channel_snippet = channel_response['items'][0]['snippet']
        profile_pic = channel_snippet['thumbnails']['default']['url']
        subscribers_count = channel_response['items'][0]['statistics'].get('subscriberCount', 'N/A')

        # Fetch comments
        comments = []
        next_page_token = None
        while len(comments) < 600:
            yt_request = youtube.commentThreads().list(part='snippet', videoId=video_id, maxResults=100,
                                                       pageToken=next_page_token)
            response = yt_request.execute()
            for item in response['items']:
                comment = item['snippet']['topLevelComment']['snippet']['textDisplay']
                comments.append(comment)
            next_page_token = response.get('nextPageToken')
            if not next_page_token:
                break

        # Sentiment Analysis
        sentiment_analyzer = SentimentIntensityAnalyzer()
        positive_comments, negative_comments, neutral_comments = [], [], []
        polarity = [sentiment_analyzer.polarity_scores(comment)['compound'] for comment in comments]

        for score, comment in zip(polarity, comments):
            if score > 0.05:
                positive_comments.append(comment)
            elif score < -0.05:
                negative_comments.append(comment)
            else:
                neutral_comments.append(comment)

        # Chart Plotting
        plt.bar(['Positive', 'Negative', 'Neutral'], [len(positive_comments), len(negative_comments), len(neutral_comments)])
        plt.xlabel('Sentiment')
        plt.ylabel('Comment Count')
        plt.savefig(f'static/assets/chart_img/{video_id}_bar_chart.png')
        plt.close()

        plt.pie([len(positive_comments), len(negative_comments), len(neutral_comments)],
                labels=['Positive', 'Negative', 'Neutral'], autopct='%1.1f%%')
        plt.savefig(f'static/assets/chart_img/{video_id}_pie_chart.png')
        plt.close()




        #  Prepare JSON response
        # analysis_data = {
        #     'video_title': video_title,
        #     'channel_name': channel_name,
        #     'profile_pic': profile_pic,
        #     'subscribers_count': subscribers_count,
        #     'total_comments': total_comments,
        #     'positive_comments': positive_comments[:5],
        #     'negative_comments': negative_comments[:5],
        #     'overall_sentiment': 'Positive' if sum(polarity) / len(polarity) > 0.05 else 'Negative' if sum(polarity) / len(polarity) < -0.05 else 'Neutral',
        #     'comment_count': {
        #         'positive': len(positive_comments),
        #         'negative': len(negative_comments),
        #         'neutral': len(neutral_comments)
        #     }
        # }





        # Convert the subscriber count to an integer if it's not 'N/A'
        if subscribers_count != 'N/A':
            subscribers_count = int(subscribers_count)

        # Define a helper function for formatting
        def format_count(count):
            if count >= 1_000_000:
                return f"{count / 1_000_000:.1f}M"  # Convert to millions (e.g., 1.2M)
            elif count >= 1_000:
                return f"{count / 1_000:.1f}K"    # Convert to thousands (e.g., 1.5K)
            else:
                return str(count)  # Return the count as is if less than 1,000

        # Format the subscriber count
        subscribers_count = format_count(subscribers_count)


        # Database Insertion
        user_id = session.get('user_id')
        if user_id and not Sentimentanalysisresult.query.filter_by(video_id=video_id, user_id=user_id).first():
            analysis_result = Sentimentanalysisresult(
                user_id=user_id,
                video_id=video_id,
                profileImage=profile_pic,
                total_subscriber=subscribers_count,
                video_title=video_title,
                channel_name=channel_name,
                total_comments=total_comments,
                rComment1 = positive_comments[0] if len(positive_comments) > 0 else "NULL",
                rComment2 = positive_comments[1] if len(positive_comments) > 1 else "NULL",
                rComment3 = positive_comments[2] if len(positive_comments) > 2 else "NULL",
                rComment4 = positive_comments[3] if len(positive_comments) > 3 else "NULL",
                rComment5 = positive_comments[4] if len(positive_comments) > 4 else "NULL",
                positive_comments=max(positive_comments, key=len, default=""),
                negative_comments=max(negative_comments, key=len, default=""),
                overall_sentiment='Positive' if sum(polarity) / len(polarity) > 0.05 else 'Negative' if sum(polarity) / len(polarity) < -0.05 else 'Neutral',
                pi_chart=f'{video_id}_pie_chart.png',
                bar_chart=f'{video_id}_bar_chart.png',
                date=datetime.today().strftime('%Y-%m-%d')
            )
            db.session.add(analysis_result)
            db.session.commit()

        return redirect(url_for('dashboard', video_id=video_id))



        # return jsonify(analysis_data)
    


    except Exception as e:
        return jsonify({'error': 'An error occurred', 'message': str(e)}), 500





@app.route("/dashboard", methods=['GET', 'POST'])
def dashboard():
    user_id = session.get('user_id')  # Fetch user_id from session
    if not user_id:
        return redirect('/login')  # Redirect if the user is not logged in

    video_id = request.args.get('video_id')  # Fetch the video ID from URL query parameters
    profile_pic = request.args.get('profile_pic')
    if not video_id:
        return redirect('/history')  # Redirect if video_id is missing

    # Fetch the result for the current user and video ID
    result = Sentimentanalysisresult.query.filter_by(video_id=video_id, user_id=user_id).first()
    if not result:
        return redirect('/history')  # Redirect if no result is found

    # Render the dashboard template with the fetched result
    return render_template("dashboard.html", video_result=result, profile_pic=profile_pic)




@app.route("/history")
def history():
    if 'user_id' in session:
        user_id = session['user_id']

        history_data = Sentimentanalysisresult.query.filter_by(user_id=user_id).all()
        return render_template("history.html", history_data=history_data)
    else:
        return redirect("/login")


@app.before_request
def check_cookie():
    if 'user_id' not in session:
        user_id = request.cookies.get('user_id')
        if user_id:
            # user = User_account.query.get(user_id)
            user = db.session.get(User_account, user_id)
            if user:
                session['user_id'] = user.user_id
                session['user_name'] = user.user_name


@app.route("/user/<int:user_id>")
def get_user(user_id):
    # user = User_account.query.get(user_id)
    user = db.session.get(User_account, user_id)
    if user:
        return jsonify(user.to_dict())
    else:
        return jsonify({"error": "User not found"}), 404


@app.route('/download_pdf/<int:video_id>')
def download_pdf(video_id):
    
    record = Sentimentanalysisresult.query.filter_by(search_id=video_id).first()

    if not record:
        return jsonify({"error": "Record not found"}), 404

    # Create a PDF in memory
    pdf_buffer = BytesIO()
    pdf = canvas.Canvas(pdf_buffer, pagesize=letter)
    width, height = letter  # Get the dimensions of the page

    # Set initial position
    x = 30
    y = 750
    line_height = 20 

    # Prepare the text to display in the PDF
    text_lines = [
        f"Video Title: {record.video_title}",
        f"Channel Name: {record.channel_name}",
        f"Total Comments: {record.total_comments}",
        f"Overall Sentiment: {record.overall_sentiment}",
        f"Most Positive Comments: {record.positive_comments}",
        f"Most Negative Comments: {record.negative_comments}",
    ]

    # Draw the text lines with automatic line height adjustment
    for line in text_lines:
        # Automatically wrap text if it exceeds the width of the page
        wrapped_lines = wrap_text(pdf, line, width - 60)  # 60 is a margin from the right edge
        for wrapped_line in wrapped_lines:
            pdf.drawString(x, y, wrapped_line)
            y -= line_height  # Move down for the next line
        y -= line_height  # Add extra space after each main entry

    # ** Add the pie chart image **
    pie_chart_path = os.path.join('static/assets/chart_img/', record.pi_chart)  # Adjust the path as necessary
    y = add_image_to_pdf(pdf, pie_chart_path, x, y)  # Update y position after adding image

    # ** Add the bar chart image **
    bar_chart_path = os.path.join('static/assets/chart_img/', record.bar_chart)  # Adjust the path as necessary
    y = add_image_to_pdf(pdf, bar_chart_path, x, y)  # Update y position after adding image

    pdf.save()
    pdf_buffer.seek(0)

    # Send the PDF file to the user
    return send_file(pdf_buffer, as_attachment=True, download_name=f"{record.video_title}.pdf")

def wrap_text(pdf, text, max_width):
    """Wrap text to fit within a specified width."""
    words = text.split(' ')
    lines = []
    current_line = ""

    for word in words:
        # Measure the width of the current line + new word
        test_line = f"{current_line} {word}".strip()
        text_width = pdf.stringWidth(test_line, 'Helvetica', 12)  # Adjust font and size as necessary

        if text_width <= max_width:
            current_line = test_line
        else:
            lines.append(current_line)  # Save the current line
            current_line = word  # Start a new line with the current word

    if current_line:  # Add any remaining text
        lines.append(current_line)

    return lines

def add_image_to_pdf(pdf, image_path, x, y):
    """Add an image to the PDF and return the new y position."""
    if os.path.exists(image_path):
        img = ImageReader(image_path)
        # Get original dimensions of the image
        img_width, img_height = img.getSize()

        # Calculate the scaling factor to fit the image within the page width
        max_width = 200  # Set your max width
        scale = max_width / img_width if img_width > max_width else 1
        new_height = img_height * scale

        # Draw the image at the specified coordinates
        pdf.drawImage(img, x, y, width=max_width, height=new_height, preserveAspectRatio=True)

        # Return the new y position after adding the image, adjusting for some space
        return y - new_height - 20  # 20 is extra space below the image
    else:
        pdf.drawString(x, y, "Image not found")  # Placeholder if the image doesn't exist
        return y - 20  # Move down for the next line if image not found


@app.route('/logout')
def logout():
    session.pop('user_id', None)
    session.pop('user_name', None)
    resp = make_response(redirect('/login'))
    resp.set_cookie('user_id', '', expires=0)  # Clear the cookie
    return resp


if __name__ == "__main__":
    app.run(debug=True)

