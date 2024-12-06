from textwrap import wrap
from flask import Flask, render_template, request, redirect, session, make_response, jsonify, url_for, send_file, flash
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail, Message
from googleapiclient.discovery import build
import re
import emoji
from matplotlib import colors
from reportlab.lib import colors
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
import matplotlib
from datetime import datetime
from io import BytesIO
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from reportlab.lib.utils import ImageReader
from reportlab.pdfbase.pdfmetrics import stringWidth
import os

matplotlib.use('Agg')  # Use a non-interactive backend
import matplotlib.pyplot as plt

app = Flask(__name__)
API_KEY = ''  # Replace with your valid YouTube API Key
youtube = build('youtube', 'v3', developerKey=API_KEY)

app.secret_key = "moodtube_secret_key"
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@localhost/moodtube'




# Mail server configuration
app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = 'rijul9848@gmail.com'  # Replace with your email
app.config['MAIL_PASSWORD'] = 'pmpp ksls tewm iboo'  # Replace with your email password
app.config['MAIL_DEFAULT_SENDER'] = 'rijul9848@gmail.com'
app.config['MAIL_DEBUG'] = True


# Initialize Flask-Mail
mail = Mail(app)




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
    # return render_template('index.html')
    is_logged_in = 'user_id' in session
    return render_template('index.html', is_logged_in=is_logged_in)


@app.route("/search", methods=['GET', 'POST'])
def search():
    is_logged_in = 'user_id' in session
    if request.method == "POST":
        # Get the search term
        search_term = request.form.get('search')

        return redirect(url_for('dashboard'))  # redirect to route named 'dashboard'

    return render_template('search_url.html', is_logged_in=is_logged_in)


@app.route("/signup", methods=['GET', 'POST'])
def signup():
    success = False
    failure = False
    message = None
    if request.method == 'POST':
        user_name = request.form.get('username')
        email = request.form.get('email')
        password = request.form.get('password')


        # Input validation
        if not user_name or not email or not password:
            failure = True
            message = "All fields are required"
            return render_template('login_signup.html', success=success, failure=failure, message=message)


        # Check if the user already exists
        existing_user = User_account.query.filter_by(email=email).first()
        if existing_user:
            failure = True
            message = "User already exists"
            return render_template('login_signup.html', success=success, failure=failure, message=message)

        entry = User_account(user_name=user_name, email=email, password=password)
        db.session.add(entry)
        db.session.commit()
        success = True
        message = "User created successfully"

    return render_template('login_signup.html',success=success, failure=failure, message=message)


@app.route("/login", methods=['GET', 'POST'])
def login():
    success = False
    failure = False
    message = None
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
            failure = True
            message = "Login Credential Invalid"
            return render_template('login_signup.html', success=success, failure=failure, message=message)

    return render_template('login_signup.html', success = success, failure = failure, message = message)



@app.route('/forgot_password')
def forgot_password():
    return render_template('forgot_password.html')





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




        # rComment1 = "NULL"

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






# old method
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

        history_data = Sentimentanalysisresult.query.filter_by(user_id=user_id).order_by(Sentimentanalysisresult.date.desc()).all()
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
    # Fetch the corresponding record from the database
    print(video_id)
    record = Sentimentanalysisresult.query.filter_by(search_id=video_id).first()

    if not record:
        return jsonify({"error": "Record not found"}), 404

    # Create a PDF in memory
    pdf_buffer = BytesIO()
    pdf = canvas.Canvas(pdf_buffer, pagesize=letter)
    width, height = letter  # Dimensions of the page

    # Set the initial position and styling
    x = 50  # Left margin
    y = height - 50  # Top margin
    line_height = 20  # Line spacing

    # Title styling
    pdf.setFont("Helvetica-Bold", 24)
    pdf.setFillColor(colors.darkblue)
    title = "YouTube Sentiment Analysis Report"
    title_width = stringWidth(title, "Helvetica-Bold", 24)
    pdf.drawString((width - title_width) / 2, y, title)  # Center the title
    y -= line_height * 2  # Move down after the title

    # Prepare the text data with better styling
    text_lines = [
        ("Video Title:", record.video_title),
        ("Channel Name:", record.channel_name),
        ("Total Comments:", str(record.total_comments)),
        ("Overall Sentiment:", record.overall_sentiment),
        ("Most Positive Comment:", record.positive_comments),
        ("Most Negative Comment:", record.negative_comments)
    ]

    # Adding text with word wrapping and a clean style
    for label, content in text_lines:
        # Draw the label with bold style
        pdf.setFont("Helvetica-Bold", 12)
        pdf.setFillColor(colors.darkblue)
        pdf.drawString(x, y, label)
        y -= line_height  # Move down after the label

        # Draw the content with normal style
        pdf.setFont("Helvetica", 12)
        pdf.setFillColor(colors.black)
        wrapped_lines = wrap_text(content, max_width=80)  # Wrap text within margins
        for wrapped_line in wrapped_lines:
            if y < 50:  # Check if there's enough space for the next line
                pdf.showPage()  # Create a new page
                y = height - 50  # Reset y position for new page
            pdf.drawString(x + 20, y, wrapped_line)  # Indent content
            y -= line_height

    # Function to add an image and check for space
    def add_image(image_path, y_position):
        if os.path.exists(image_path):
            image_reader = ImageReader(image_path)
            image_width, image_height = image_reader.getSize()  # Get actual image dimensions
            aspect_ratio = image_width / float(image_height)
            new_height = 300  # Set a larger desired height for the image
            new_width = new_height * aspect_ratio  # Maintain aspect ratio

            # Check if there's enough space for the image plus some padding
            if y_position - new_height - 10 < 50:  # If not enough space, create a new page
                pdf.showPage()  # Create a new page
                y_position = height - 50  # Reset y position for new page

            # Draw the image centered
            pdf.drawImage(image_reader, (width - new_width) / 2, y_position - new_height, width=new_width, height=new_height)  # Center the image
            return y_position - new_height - 10  # Reduce space below the image
        return y_position - line_height  # If image not found, just move down

    # Add pie chart image
    if record.pi_chart:
        pie_chart_path = os.path.join('static/assets/chart_img/', record.pi_chart)
        y = add_image(pie_chart_path, y)

    # Add bar chart image
    if record.bar_chart:
        bar_chart_path = os.path.join('static/assets/chart_img/', record.bar_chart)
        y = add_image(bar_chart_path, y)

    # Finalize the PDF
    pdf.showPage()  # Correct method to finalize the current page
    pdf.save()  # Save the PDF to the buffer
    pdf_buffer.seek(0)  # Move to the beginning of the BytesIO buffer

    # Send the PDF file to the user
    return send_file(pdf_buffer, as_attachment=True, download_name='sentiment_analysis_report.pdf', mimetype='application/pdf')

def wrap_text(line, max_width):
    words = line.split(' ')
    wrapped_lines = []
    current_line = ""

    for word in words:
        if len(current_line + word) <= max_width:
            current_line += word + " "
        else:
            wrapped_lines.append(current_line.strip())
            current_line = word + " "

    if current_line:
        wrapped_lines.append(current_line.strip())

    return wrapped_lines




@app.route('/delete_video', methods=['POST'])
def delete_video():
    data = request.get_json()  # Parse the incoming JSON data
    search_id = data.get('search_id')  # Correctly access 'search_id' from the data

    Sentimentanalysisresult.query.filter_by(search_id=search_id).delete()
    db.session.commit()
    response = {"success": True, 'message': 'Video deleted'}
    return jsonify(response)




@app.route("/send_email", methods=["POST"])
def send_email():
    email = request.form.get("email")
    success = False
    failure = False
    message = None
   
    user = User_account.query.filter_by(email=email).first()
    if user:
        password = user.password
        # Create the email message
        msg = Message(
            "Welcome to the Email Service Demo!",
            recipients=[email],
            body=f"Hello! Welcome to MoodTube. Your Password is {password}"
        )
        try:
            mail.send(msg)                                                                            
            flash("Email sent successfully!", "success")
            success = True
            message = "Password sent to your email"
        except Exception as e:
            failure = True
            message = f"Failed to send email: {str(e)}"
    else:
        failure = True
        message = "User not found"

    return render_template('login_signup.html', success=success, failure=failure, message=message)

    




@app.route('/logout')
def logout():
    session.pop('user_id', None)
    session.pop('user_name', None)
    resp = make_response(redirect('/login'))
    resp.set_cookie('user_id', '', expires=0)  # Clear the cookie
    return resp


if __name__ == "__main__":
    app.run(debug=True)

