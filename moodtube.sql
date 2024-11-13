-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 12, 2024 at 12:03 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `moodtube`
--

-- --------------------------------------------------------

--
-- Table structure for table `sentimentanalysisresult`
--

CREATE TABLE `sentimentanalysisresult` (
  `search_id` int(10) NOT NULL,
  `video_id` varchar(200) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `profileImage` varchar(150) NOT NULL,
  `total_subscriber` varchar(10) NOT NULL,
  `video_title` varchar(200) NOT NULL,
  `channel_name` varchar(100) NOT NULL,
  `total_comments` int(10) NOT NULL,
  `rComment1` varchar(1000) NOT NULL,
  `rComment2` varchar(1000) NOT NULL,
  `rComment3` varchar(1000) NOT NULL,
  `rComment4` varchar(1000) NOT NULL,
  `rComment5` varchar(1000) NOT NULL,
  `positive_comments` varchar(1000) NOT NULL,
  `negative_comments` varchar(1000) NOT NULL,
  `overall_sentiment` text NOT NULL,
  `pi_chart` text NOT NULL,
  `bar_chart` text NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sentimentanalysisresult`
--

INSERT INTO `sentimentanalysisresult` (`search_id`, `video_id`, `user_id`, `profileImage`, `total_subscriber`, `video_title`, `channel_name`, `total_comments`, `rComment1`, `rComment2`, `rComment3`, `rComment4`, `rComment5`, `positive_comments`, `negative_comments`, `overall_sentiment`, `pi_chart`, `bar_chart`, `date`) VALUES
(1, NULL, 1, '', '', '1sdsfsd', '', 0, '', '', '', '', '', '', '', '', '', '', '0000-00-00'),
(2, NULL, NULL, '', '', '', '', 0, '', '', '', '', '', '', '', '', '', '', '0000-00-00'),
(3, NULL, 6, '', '', 'Aasman Rootha | Official Music Video | Panchayat Season 3 | Swanand Kirkire, Anurag Saikia, JUNO', 'TVF Music', 614, '', '', '', '', '', '❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤', '😢😢😢😢😢😢😢😢😢😢😢😢V', 'Positive', 'None', 'None', '2024-10-25'),
(4, NULL, 6, '', '', 'Aasman Rootha | Official Music Video | Panchayat Season 3 | Swanand Kirkire, Anurag Saikia, JUNO', 'TVF Music', 614, '', '', '', '', '', '❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤', '😢😢😢😢😢😢😢😢😢😢😢😢V', 'Positive', 'None', 'None', '2024-10-25'),
(5, NULL, 6, '', '', 'आप जाग रहे हैं या नहीं?', 'Ravish Kumar Official', 5360, '', '', '', '', '', '❤❤❤❤❤❤❤❤❤❤❤❤🎉🎉🎉🎉🎉🎉🎉🎉🎉BiLkooL Sahee Baat 🎉🎉🎉🎉🎉🎉🎉❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤l❤❤❤❤❤❤', 'Why you always tell opposite to bjp 😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢🎉🎉🎉🎉🎉😢😢😢😢😢', 'Positive', '\'static/assets/chart_img/\'+ video_id + \'pie_chart.png\'', 'None', '2024-10-25'),
(6, NULL, 6, '', '', 'Aasman Rootha | Official Music Video | Panchayat Season 3 | Swanand Kirkire, Anurag Saikia, JUNO', 'TVF Music', 614, '', '', '', '', '', '❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤', '😢😢😢😢😢😢😢😢😢😢😢😢V', 'Positive', '57ATmXx-uUkpie_chart.png', 'None', '2024-10-25'),
(7, NULL, 6, '', '', 'आप जाग रहे हैं या नहीं?', 'Ravish Kumar Official', 5365, '', '', '', '', '', '❤❤❤❤❤❤❤❤❤❤❤❤🎉🎉🎉🎉🎉🎉🎉🎉🎉BiLkooL Sahee Baat 🎉🎉🎉🎉🎉🎉🎉❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤l❤❤❤❤❤❤', 'Why you always tell opposite to bjp 😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢🎉🎉🎉🎉🎉😢😢😢😢😢', 'Positive', 'ZAgBPYejFf0pie_chart.png', 'None', '2024-10-25'),
(8, NULL, 6, '', '', 'आप जाग रहे हैं या नहीं?', 'Ravish Kumar Official', 5365, '', '', '', '', '', '❤❤❤❤❤❤❤❤❤❤❤❤🎉🎉🎉🎉🎉🎉🎉🎉🎉BiLkooL Sahee Baat 🎉🎉🎉🎉🎉🎉🎉❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤l❤❤❤❤❤❤', 'Why you always tell opposite to bjp 😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢🎉🎉🎉🎉🎉😢😢😢😢😢', 'Positive', 'ZAgBPYejFf0pie_chart.png', 'ZAgBPYejFf0bar_chart.png', '2024-10-25'),
(9, NULL, 6, '', '', 'SCREWDRIVER कहा चला गया ❔❔❔Movie Dhamaal | Best Comedy Scenes | Vijay Raaz - Asrani  -Javed Jaffery', 'Shemaroo Comedy', 1112, '', '', '', '', '', '🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤠🤠🤠🤠🤠🤠🤠🤠🤠🤠😱😱😭👌👌👌👌👌👌👌👌👌👌👌👌👌👌👌💪💪💪💪👀👀👀👀👀', '🔥🔥🌹🌹🔥iAm  youTuber🔥🔥🔥मे YouTuber हू🔥🔥🔥mera Tech changennol hair🔥🔥🔥🔥mere channels Asoka help🔥🔥🔥Ho sakota had 🔥🔥🔥Nice video🔥🔥', 'Positive', 'gr_oUv_cSaIpie_chart.png', 'gr_oUv_cSaIbar_chart.png', '2024-10-25'),
(10, NULL, 6, '', '', 'Aasman Rootha | Official Music Video | Panchayat Season 3 | Swanand Kirkire, Anurag Saikia, JUNO', 'TVF Music', 615, '', '', '', '', '', '❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤', '😢😢😢😢😢😢😢😢😢😢😢😢V', 'Positive', '57ATmXx-uUkpie_chart.png', '57ATmXx-uUkbar_chart.png', '2024-10-25'),
(11, NULL, 6, '', '', 'Aasman Rootha | Official Music Video | Panchayat Season 3 | Swanand Kirkire, Anurag Saikia, JUNO', 'TVF Music', 615, '', '', '', '', '', '❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤', '😢😢😢😢😢😢😢😢😢😢😢😢V', 'Positive', '57ATmXx-uUkpie_chart.png', '57ATmXx-uUkbar_chart.png', '2024-10-25'),
(12, 'nRPb6O05Lsw', 6, '', '', 'How to Stop Overthinking? By Sandeep Maheshwari I Hindi', 'Sandeep Maheshwari', 8996, '', '', '', '', '', '❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤', 'Year overthing jaab karta hoon problem  nhi haai but Nind main Problem  hota haai Lagta haai muje Suicide  karna adega nhi tw kuch nhi hoga 😭😭😭😭 Main Muslim  hoon isliye suicide nhi kar pa raha hoon', 'Positive', 'nRPb6O05Lswpie_chart.png', 'nRPb6O05Lswbar_chart.png', '2024-10-25'),
(13, 'nRPb6O05Lsw', 1, '', '', 'How to Stop Overthinking? By Sandeep Maheshwari I Hindi', 'Sandeep Maheshwari', 8996, '', '', '', '', '', '❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤', 'Year overthing jaab karta hoon problem  nhi haai but Nind main Problem  hota haai Lagta haai muje Suicide  karna adega nhi tw kuch nhi hoga 😭😭😭😭 Main Muslim  hoon isliye suicide nhi kar pa raha hoon', 'Positive', 'nRPb6O05Lswpie_chart.png', 'nRPb6O05Lswbar_chart.png', '2024-10-25'),
(14, 'ZAgBPYejFf0', 6, '', '', 'आप जाग रहे हैं या नहीं?', 'Ravish Kumar Official', 5399, '', '', '', '', '', '❤❤❤❤❤❤❤❤❤❤❤❤🎉🎉🎉🎉🎉🎉🎉🎉🎉BiLkooL Sahee Baat 🎉🎉🎉🎉🎉🎉🎉❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤l❤❤❤❤❤❤', 'Why you always tell opposite to bjp 😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢🎉🎉🎉🎉🎉😢😢😢😢😢', 'Positive', 'ZAgBPYejFf0pie_chart.png', 'ZAgBPYejFf0bar_chart.png', '2024-10-25'),
(15, 'RyyPtdMgpRg', 6, '', '', 'How to Start a New Python Project the Right Way', 'ArjanCodes', 4, '', '', '', '', '', '👷 Join the FREE Code Diagnosis Workshop to help you review code more effectively using my 3-Factor Diagnosis Framework: <a href=\"https://www.arjancodes.com/diagnosis\">https://www.arjancodes.com/diagnosis</a>', 'you can also ask chatGPT&#39;s opinion...:)', 'Positive', 'RyyPtdMgpRgpie_chart.png', 'RyyPtdMgpRgbar_chart.png', '2024-10-27'),
(16, '57ATmXx-uUk', 6, '', '', 'Aasman Rootha | Official Music Video | Panchayat Season 3 | Swanand Kirkire, Anurag Saikia, JUNO', 'TVF Music', 617, '', '', '', '', '', '❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤', '😢😢😢😢😢😢😢😢😢😢😢😢V', 'Positive', '57ATmXx-uUkpie_chart.png', '57ATmXx-uUkbar_chart.png', '2024-10-31'),
(17, 'IIZyKWyz2Lk', 6, '', '', 'Prakash Raj Threatens Ajay Devgn | Singham | Movie Scene', 'RelianceEntertainment', 735, '', '', '', '', '', '❤❤❤❤❤❤❤❤❤❤🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉🎉', 'KIYA KOI MERI MADAD KAR SAKTA MEIN BOHT BADI SAZISH KA SHIKAR HUN MUJHE BEMAR KIA GYA US BEMARI KA ILAJ PURE MULK MEIN BAND KARWAYA MUJHE ILAJ KE BAHANE BAD TARIN SEXUAL VIOLENCE MEIN MARNE KI KOSHISH KI GAI IZZAT SE JAN SE KHELA GYA AUR US BEMARI KO BURI TARHAN BARHANE KI KOSHISH KI JAA RAHI HAI KOI KAHIN BHI HELP NAHIN KARTA MEDIA JAWAB NA DETA MERI HELP KIJIYE MEDIA KE ZARIYE INKO PURI DUNYA KE SAMNE ZALIL KARKE SAKHT TARIN SAZA DILWANE MEIN PLEASE😢😢😢', 'Positive', 'IIZyKWyz2Lkpie_chart.png', 'IIZyKWyz2Lkbar_chart.png', '2024-11-09'),
(18, 'gWDX7wniTZY', 6, '', '', 'Paise Kaha Se Aaye Triumph Tiger 900 Rally Pro Lene Ke Liye?', 'MSK', 145, '', '', '', '', '', 'Aaa rha he...aaa rha h.. pehele vala MSk......aan do aan do😂😂😂😂😂😂😂❤❤❤❤❤❤❤❤❤❤❤❤❤❤❤', 'Bro s old content 💎 bro s new content 🤡<br>Salim bhai wapis aaw 😢<br>Old msk kaha hoo tum 😭😭', 'Positive', 'gWDX7wniTZYpie_chart.png', 'gWDX7wniTZYbar_chart.png', '2024-11-09'),
(19, 'lHLBJ4yRMn8', 6, '', '', 'American Airlines | Stand Up Comedy | Ft  @AnubhavSinghBassi', 'be_a_bassi', 587, '', '', '', '', '', '😂😂😂😂😂😂😂😂😂😂😂❤❤❤❤❤❤❤❤', 'Aree yee dekho yee jinda hai 😱😱', 'Positive', 'lHLBJ4yRMn8pie_chart.png', 'lHLBJ4yRMn8bar_chart.png', '2024-11-09'),
(20, 'V3MwXPwjGqM', 6, 'https://yt3.ggpht.com/1Q95GetscCjEYwZN46TtY8vwqfa-z3oQDTetkoybYsd7yNrIPKPOudveqvI1KCw09HcJvq3j=s88-c-k-c0x00ffffff-no-rj', '451000', '4 Simple Habits for Discipline without destroying yourself | Drishti Sharma', 'Drishti Sharma', 591, 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', '<a href=\"https://www.youtube.com/watch?v=V3MwXPwjGqM&amp;t=1\">00:01</a> Building good habits and proper discipline can help you achieve anything in life.<br><a href=\"https://www.youtube.com/watch?v=V3MwXPwjGqM&amp;t=76\">01:16</a> Adopting the habit of meditation for discipline<br><a href=\"https://www.youtube.com/watch?v=V3MwXPwjGqM&amp;t=149\">02:29</a> Having a consistent morning routine sets the tone for the day.<br><a href=\"https://www.youtube.com/watch?v=V3MwXPwjGqM&amp;t=217\">03:37</a> Establish a morning routine for discipline<br><a href=\"https://www.youtube.com/watch?v=V3MwXPwjGqM&amp;t=285\">04:45</a> Understanding and managing your energy levels is crucial for effective time management<br><a href=\"https://www.youtube.com/watch?v=V3MwXPwjGqM&amp;t=352\">05:52</a> Setting boundaries with gadgets and prioritizing tasks<br><a href=\"https://www.youtube.com/watch?v=V3MwXPwjGqM&amp;t=419\">06:59</a> Continuous learning is essential for personal growth and success.<br><a href=\"https://www', 'hii ma&#39;am <br>aaj muje randomly apki video mili or mene use dekha muje bahot achi lagi thankyou mam<br>ma&#39;am me ek upsc aspirents hu mera abhi exam bhi hai 16 june me, mam mere jese jese exam pas aa rahe hai mera aalas bad raha hai pata nhi kyu muje ese lg raha jese mera junun khatam ho gaya hai  aajkl mere sath bahot ajib cheez ho rahi hai me subah jese hi uthti hu muje veses hi or need aane lagti hai pata nhi esa kyu ho raha hai padne bethete hai to pad nhi pa rahi hu  me janti hu ye alas hai lekin me isse deal nhi kr pa rahi hu mam please help me mam🙏🙏', 'Positive', 'V3MwXPwjGqM_pie_chart.png', 'V3MwXPwjGqM_bar_chart.png', '2024-11-11'),
(21, 'TImJlp8ODvQ', 6, 'https://yt3.ggpht.com/ytc/AIdro_klgvZS3LdOlpIBdznBEu5HN4pLP_IpOpGizLu6c7t2Tc8=s88-c-k-c0x00ffffff-no-rj', '3150000', 'Visiting the Famous Hollywood Sign!', 'Dhruv Rathee Vlogs', 1300, 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', '….How to have choice of gender? Can visit YouTube channel: चर्चा Discussion by Ajay Simon Sir! Welcome and Thanks 😊 🙏 P.S. Suggestion for Juliejee not to drop out from Medical Graduation 👩‍🎓 before completion because richness spoils and not allow to train the mind to think in complex situations; uneducated mind more often than not short circuits and doesn’t take the long cool path to THINK to solve complex problems of life! Thanks and Welcome 🙏 <br><br>.... लिंग का चुनाव कैसे करें? YouTube चैनल पर जा सकते हैं: अजय साइमन सर द्वारा चर्चा चर्चा! स्वागत और धन्यवाद पी.एस. जूलीजी के लिए सुझाव है कि मेडिकल ग्रेजुएशन पूरा होने से पहले न छोड़ें क्योंकि अमीरी खराब करती है और जटिल परिस्थितियों में दिमाग को सोचने के लिए प्रशिक्षित नहीं करती है; अशिक्षित दिमाग अक्सर शॉर्ट सर्किट होता है और जीवन की जटिल समस्याओं को हल करने के लिए सोचने के लिए लंबा ठंडा रास्ता नहीं अपनाता है! धन्यवाद और स्वागत 🙏', 'Here is the point that people are missing: Electricity doesn&#39;t come for free. Now, they are intentionally keeping charging prices at low levels or at zero, just to incentivize people to switch to electric cars. However, when most of the people have indeed switched over to electric cars, the charging will cost similar to what filling your tank with gasoline would cost.<br><br>Also, that parking lot was filled with Tesla Superchargers, which uses a proprietary charging connector, making it incompatible with other cars. That is why you didn&#39;t see other cars in the parking lot. Also, this was the precise reason why Europe passed a law mandating all electric cars and chargers to use the CCS standard connector. Elon Musk attempted to fight this ruling, but the EU is not like America, and dug its heels in, forcing him to adhere to the standard for his European Model Teslas.', 'Positive', 'TImJlp8ODvQ_pie_chart.png', 'TImJlp8ODvQ_bar_chart.png', '2024-11-11'),
(22, 'gCRNEJxDJKM', 6, 'https://yt3.ggpht.com/-Weca7gZCAF0tBcPwbpITNNyT8Rp2omE9U4Puf8L2JmG7k7eF5hkfA74fFftt-NR4A-ajJcbwFM=s88-c-k-c0x00ffffff-no-rj', '858000', 'Nepal In 4K - Country Of The Highest Mountain In The World | Scenic Relaxation Film', 'Scenic Scenes', 1072, 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', 'I am extremely proud to call myself  Nepali after watching this breathtaking video. It beautifully captures the essence of our country, showcasing the majesty of Earth&#39;s highest mountains, including the legendary Mount Everest. Nepal&#39;s geography is not only breathtaking; it is the  backbone of our country. Although the rugged terrain poses many challenges, it also brings resilience and strength to our people. It has shaped our lifestyles, traditions and economies. Talking about the economy, Nepal&#39;s terrain plays a key role. The mountaineering industry, centered around iconic regions such as Annapurna and Everest, is fundamental to our economy. It attracts explorers and adventurers  from all over the world, providing a livelihood for many. But there&#39;s more than that. The rivers flowing down from our mountains have enormous potential for hydroelectric power generation. If harnessed wisely, this could be a game changer for our energy needs and even open up export routes. H', 'Reyhanzil salceda I lived in Brgy milagrosa alang alang Leyte pls boardcast the tv all channel tv ....because they are make a porn sex inside your sd ....sometimes iam a boy and also sometimes iam a girl ....pls asking for all journalism .....because they are kill me someday ...also.....and they are climb the rooftop in my house everyday......pia mueva and Mario s brazil Jeffrey salceda and Melvin brazil and biboy brazil .and salceda cong Cong and salceda Wilmer ...pls understand me .....<br>If you read my message ..and boardcast all channel tv every 5 hours Monday to Sunday all tv abroad', 'Positive', 'gCRNEJxDJKM_pie_chart.png', 'gCRNEJxDJKM_bar_chart.png', '2024-11-11'),
(23, 'qYMLlByo0_Y', 6, 'https://yt3.ggpht.com/xSr4m3qtrIX20bYSRwEpQXfy_rqucNqL5fL6Uvx0j7HACO1TahRJGLL1hGFsAMdLFO_zKmZR8w=s88-c-k-c0x00ffffff-no-rj', '864000', 'Unexplored Tribal Village of India in Arunachal Pradesh | Ziro Valley | Northeast India', 'Kanishk Gupta', 4866, 'Today my eyes watching the beautiful earth 🌎', 'Meghalaya is the best❤❤', 'Wow 😮😊', 'Your video very informative with drone view ❤', 'Good representation. Thank u for promoting NE tourism', 'Thanks for creating these beautiful videos, Kanishk. You have brought serenity and the ultimate sense of falling in love with mother nature to your thousands of viewers. Beautiful landscapes captured with long shots, aerial views, soft picture tone, soothing bgm along with your equally calm, slow-paced voice has made the entire experience of watching these films really mesmerizing and divine. 💖I am hooked to your films and devouring onto it one per day, do not want finish it in one go, want to stretch it as far as I can. 😄 <br>Only fear is that people should not pour in there at those remote parts of our nation in large numbers and disturb the long sustained and maintained balance there. Overtourism is fearsome these days. <br>All the best to you and your team for your upcoming projects. Hope, we would keep on receiving many such relaxing films to watch made by you guys. Indeed, great work of quality. Many congratulations. Keep the good working going on. 👍👏😊', 'Hindi nahi aana is quite natural. Aapko bhi toh nahi aati unka language. <br>Tum North Indians ka yehi problem hai..... Never respect local demography.<br>Dont look down upon them this way..... Instead ask people  politely &quot; Kya aapko Hindi aati hai?&quot; 😡', 'Positive', 'qYMLlByo0_Y_pie_chart.png', 'qYMLlByo0_Y_bar_chart.png', '2024-11-11'),
(24, 'SdHe-JseJfQ', 6, 'https://yt3.ggpht.com/HeLRD38z8LXXOZiI02wlLcVUiYxpSTFZkb_2szN2r0cDcnQLSiq7baYHyIitDXneGXYnS6g3Gg=s88-c-k-c0x00ffffff-no-rj', '527000', 'OPPENHEIMER - New Hindi Trailer (Universal Pictures) - HD', 'Universal Pictures India', 3029, 'Chillian Murphy is the best for the character of Dr doom', 'Dubbing is by Sanket Mhatre ❤❤', 'Literally I watched this movie 6 times but my brain said that one more time. I just love it', 'They got 7 Oscar and 5 golden global award... 🎉🎉🎉', '❤', 'Пора говорить ПРЯМО. ВСЁ ИСКУССТВО: КИНО, ТЕАТР, МУЗЫКА, КНИГИ, ПОЭЗИЯ , имеет ИСКЛЮЧИТЕЛЬНО ДВА ГЛОБАЛЬНЫХ СМЫСЛА , либо служит ПРОСЛАВЛЕНИЮ БОЖЬЕГО СЛОВА , либо дьяволу. Служить БОЖЬЕМУ СЛОВУ это значит , каждым КАДРОМ, РЕПЛИКОЙ, КУПЛЕТОМ и т.п. &quot;ПРИВОДИТЬ&quot; НАС, ЗРИТЕЛЕЙ, СЛУШАТЕЛЕЙ к ПОКАЯНИЮ, СПАСЕНИЮ ДУШИ, и соответственно наоборот, максимально удалять от него. <br><br>МЕРЗКОЕ сатанинское КИНО. Под видом исторического сюжета скрывается обычная ДЬЯВОЛЬСКАЯ НАСМЕШКА И пример МАНИПУЛЯЦИИ душой человека, а ПОЧЕМУ надо понимать следующее. НО СНАЧАЛА. Любое УПОМИНАНИЕ в фильме О БОГЕ, ВСУЕ(что значит обращения к Богу без молитвы и благовейного состояния), а главное название этой небогоугодной операции это обычное БОГОХУЛЬСТВО(ХУЛА на ДУХА СВЯТОГО), самый СТРАШНЫЙ ГРЕХ если прельститься. НО БОГА ОБИДЕТЬ НЕ ВОЗМОЖНО ОН БЕССТРАСТЕН, А вот ХУЛА ЕГО это БОЛЬШОЙ ГРЕХ. А ГРЕХ это РАНА которую человек наносит прежде всего сам СВОЕЙ ДУШЕ. РАНА которая ОТКРЫВАЕТ ДУШУ ДЛЯ ДЕМОНОВ мучител', 'The Bhagvad Gita wasn&#39;t translated to English by Bob, but by his tutor at UC Berkeley, Arthur Ryder. The original Sanskrit version says &quot;Kaal&quot;. Kaal means Time.\r<br>\r<br>Context: In the battle of Mahabharata, on the battlefield, the prince Arjuna felt helpless on seeing his loved ones on the other side of the battlefield. He knew his battle skills &amp; thought that while fighting his own cousins &amp; teachers, he&#39;d end up killing them or at least severely injuring them. This threw him into a dilemma (much like what Oppenheimer faced after the nuclear tests). His charioteer, Krishna, tried to motivate him, but in vain. In a sort of last ditch attempt, Krishna who is actually the avatar of Lord Vishnu, took the form of his Eternal Self, as Lord Vishnu, and recited the Gita to Arjuna, telling him how he needs to do his duties because He i.e. God, intended it that way. Lord Vishnu&#39;s detailed advice is what the Bhagvad Gita basically is.\r<br>\r<br>This dialogue that h', 'Positive', 'SdHe-JseJfQ_pie_chart.png', 'SdHe-JseJfQ_bar_chart.png', '2024-11-11'),
(25, '_DLYL1LD4G4', 6, 'https://yt3.ggpht.com/ytc/AIdro_kXBVZgqtwIbSMxDqTnSc-vuiWSVqmEbyS-Jt3wZzKSNYs=s88-c-k-c0x00ffffff-no-rj', '1750000', 'Taking My New Superbike \'Triumph Tiger 900 Rally Pro\' Home 😍 | Mumbai Meetup vlog', 'MSK', 519, 'Congratulations 🎉', 'Congratulations MSK bhai❤❤', '🤣🤣🤣🤣 memes wala bhari tha lee mskians', 'This adventure bike but why are you calling super bike?', 'Congratulations MSK bro🎉🎉', 'Bengal mei butterfly ka ghar mei ana matlab shaadi hone wali hai joh apki ho chuki hai tiger mane tigress bike ko wapas le aye hain. Meri favourite bike thi apki peheli wala tiger jab apne usko dedia bada dukh hua tha lekin wapas se kushi hogai yeh vlog dekh ke.❤ Thank you Salim ji Tiger ko wapas lane ke liye.❤ Congratulations very much😊🎉❤', 'Bhai Salaam, No disrespect. Just a can&#39;t curiousness. Aap ghar kyun nahi banwate ho acchi wali, Uncle Aunty ko ghumane kyun nahi ke jatey ho? Bikes toh hain aapke paas. I might be wrong.. I don&#39;t watch you regularly.', 'Positive', '_DLYL1LD4G4_pie_chart.png', '_DLYL1LD4G4_bar_chart.png', '2024-11-12'),
(26, 'HQ05vkrWfO0', 6, 'https://yt3.ggpht.com/QSme4pYXcq62yjfjx4yOtBa9pe4sryzRinjG94VjfViZ6ND1xwdo0NGVEAFQPJg-qhhiC2bHFA=s88-c-k-c0x00ffffff-no-rj', '12.1K', 'Tumi Oha Bate | Papon | Rajmukut Theatre 2024-25 | Harjeet Diaz | Moharonor Boliya Ghora |', 'Production of Rajmukut theatre', 186, 'Proud of you bidyut Da ❤️🫶🥳', 'Nice song', 'Very nice song with your sweet voice', '<a href=\"https://www.youtube.com/watch?v=HQ05vkrWfO0&amp;t=50\">0:50</a> 💗💗', 'akal manash da nahai mantu da o mar bae deuta 2nd malik 😊❤', 'No offence or any disrespect to Papon, but the feel of this song in Zubeen&#39;s voice would have been in a different universe altogether. Still one of Papon&#39;s top songs, yet this genre belongs to Zubeen.', 'Gunjan is pathetic as a stage actor. He needs to learn many things. Kindly don&#39;t give him any significant roles. Otherwise he&#39;ll spoil everything. He doesn&#39;t know how to act. He doesn&#39;t know how to express. He doesn&#39;t know how to fight. He doesn&#39;t know how to stand.... And many more. He&#39;s just intolerable on stage.', 'Positive', 'HQ05vkrWfO0_pie_chart.png', 'HQ05vkrWfO0_bar_chart.png', '2024-11-12');

-- --------------------------------------------------------

--
-- Table structure for table `user_account`
--

CREATE TABLE `user_account` (
  `user_id` int(10) NOT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_account`
--

INSERT INTO `user_account` (`user_id`, `user_name`, `email`, `password`) VALUES
(1, 'Rijul ali', 'rijulali54@gmail.com', 'my password'),
(5, 'ddd', 'admin01@gmail.com', 'dd'),
(6, 'Rijul Ali', 'rijulali674@gmail.co', '1234'),
(7, 'testing', 'testing@gamil.com', '111111'),
(8, 'test', 'testing8786@gmail.co', '555555'),
(9, 'sdfsdfds', 'admin02@gmail.com', 'ddddddddd'),
(10, 'Rijul Ali', 'admin051@gmail.com', '89465313');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `sentimentanalysisresult`
--
ALTER TABLE `sentimentanalysisresult`
  ADD PRIMARY KEY (`search_id`),
  ADD KEY `fk_user` (`user_id`);

--
-- Indexes for table `user_account`
--
ALTER TABLE `user_account`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `sentimentanalysisresult`
--
ALTER TABLE `sentimentanalysisresult`
  MODIFY `search_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `user_account`
--
ALTER TABLE `user_account`
  MODIFY `user_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `sentimentanalysisresult`
--
ALTER TABLE `sentimentanalysisresult`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `user_account` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
