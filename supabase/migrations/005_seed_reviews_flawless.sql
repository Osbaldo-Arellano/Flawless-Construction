-- ============================================================
-- Migration 005 — Seed Google Reviews: Flawless Construction and Roofing
-- ============================================================
-- Replace 'YOUR_USER_UUID_HERE' with the actual UUID from auth.users
-- before running this script.
-- ============================================================

DO $$
DECLARE
  uid uuid := 'f93fd325-bf93-4dc5-8db7-8124f7e50c6b';
BEGIN

INSERT INTO public.brand_reviews
  (user_id, reviewer_name, rating, body, source, sort_order)
VALUES
  (uid, 'Charise Brady', 5,
   'I had my roof replaced by Flawless March 2024. Rene was my contact. Very professional and personable. The crew came out the day I was told. Got the job done quickly. I''m a senior citizen and I tend to worry a lot. I had a spot in my dining room that had bubbled under the wallpaper. Rene made a special trip out — I live about 30 minutes from him. It doesn''t look like there''s a leak at all, just old wallpaper. I appreciate him taking the time to come out to my house and check it out. Thank you to Rene and his crew for making the experience easy and pleasant.',
   'google', 1),

  (uid, 'Taryn McKillion', 5,
   'I''ve had many great experiences working with Flawless Roofing. Great communication, competitive pricing, honesty, and quality work are just a few of the reasons behind my 5-star review. I would definitely recommend Flawless Roofing to anyone needing roofing work and already have!',
   'google', 2),

  (uid, 'Jaret Prokay', 5,
   'I highly recommend Flawless Roofing and Construction. Great pricing and they''re great at communicating. I had them clean my roof and gutters. They did an amazing job.',
   'google', 3),

  (uid, 'Charles Bates', 5,
   'Luciano''s crew did a great job. You couldn''t ask for a better roof. Pricing was good, cleanup was perfect, very impressive. Good to know there''s a leak warranty. Highly recommended.',
   'google', 4),

  (uid, 'Alex Lang', 5,
   'Great work from Rene and his team, really appreciate all he''s done for me and would gladly recommend him in the future!',
   'google', 5),

  (uid, 'Ivan', 5,
   'Great quality work, knowledgeable team, great customer service!',
   'google', 6),

  (uid, 'Teresa T', 5,
   'Had the pleasure of working with Rene on my roof replacement. His crew was great, efficient and professional. Highly recommend him if you''re looking to get a new roof. I could not be happier with the results.',
   'google', 7),

  (uid, 'Catherine K', 5,
   'Rene and his team did a great job replacing our roof and skylights! He answered all our questions beforehand and offered a great, competitive price. They got the job done in one day and did quality work.',
   'google', 8),

  (uid, 'Chris Moore', 5,
   'Flawless roofing went above and beyond to get our roof done so we could move into our new home without extending closing. Fast, high quality, and friendly. Highly recommended.',
   'google', 9),

  (uid, 'Zach Traina', 5,
   'This company is amazing. They provided a very competitive quote. Completed the job faster than originally discussed and left my yard so clean I would not have known they were here. In addition to replacing the roof, they also replaced some additional areas I hadn''t originally expected.',
   'google', 10),

  (uid, 'Brian Lee', 5,
   'Rene and his team were outstanding. They were on time and were able to get the roof demoed/replaced in one day. If we ever need our roof replaced again, we will be choosing Flawless Roofing.',
   'google', 11),

  (uid, 'T. Eslinger', 5,
   'Very efficient and friendly. I would highly recommend!',
   'google', 12),

  (uid, 'Marilyn Morgan', 5,
   'Flawless Roofing did an awesome job installing our roof. They were very professional and hard working. I highly recommend them.',
   'google', 13),

  (uid, 'Joshua Morrison', 5,
   'Rene and his team did a great job. I would highly recommend them!',
   'google', 14),

  (uid, 'Jamie Wilmarth', 5,
   'I think the exclusively 5-star reviews says it all. Professional, great quality, excellent communication/customer service and affordable on top of everything else! Couldn''t be happier.',
   'google', 15),

  (uid, 'Molly Matlock', 5,
   'Great experience! Love our new roof! Rene was great to work with. They take good care of you without trying to take all of your money.',
   'google', 16),

  (uid, 'Kris Upchurch', 5,
   'Rene was great to work with. They were able to squeeze my roof install into their schedule. Did an amazing professional job and cleaned up well after everything was said and done. Would definitely recommend this company for your roofing needs.',
   'google', 17),

  (uid, 'Vincent Home', 5,
   'Five-star review.',
   'google', 18),

  (uid, 'Kelly Wear', 5,
   'Flawless roofing did a fabulous job on a roof I needed done for some sellers. They were extremely timely and offered a great bid. The roof looks amazing and I will definitely use them in the future!',
   'google', 19),

  (uid, 'Taryn McKillion', 5,
   'Working with Rene and his team at Flawless Roofing was a great experience! He was very responsive, provided an estimate right away, scheduled us within a week and got the job done quickly! The whole time we worked with Flawless you could tell they truly cared about the customer.',
   'google', 20),

  (uid, 'Nicole P', 5,
   'Affordable roof replacement, honest owner, great workmanship, very happy with how my roof looks — before and after photos included. Would recommend to my family.',
   'google', 21),

  (uid, 'Lindsay Rector', 5,
   'Five-star review.',
   'google', 22),

  (uid, 'Freddy quirino', 5,
   'Five-star review.',
   'google', 23),

  (uid, 'Misha', 5,
   'I needed an older roof replaced, and Rene''s company Flawless Roofing was recommended to me by a friend who had used them for a new roof a couple years before. I got estimates from a couple other companies as well, but I''m glad I chose Flawless Roofing. The price was good, the warranty on his work gives peace of mind, and the work done was great. The crew was hardworking and professional and did a great job of clean up at the end of each day. Highly recommended.',
   'google', 24),

  (uid, 'Randall Goree', 5,
   'Flawless Roofing was amazing and we recommend them highly. We received numerous bids to have our home reroofed and Flawless gave us absolutely the best bid. They were extremely professional and worked very hard. They are easy to work with and we are so happy with the end result. Great company and great owner. Thank you Flawless Roofing.',
   'google', 25),

  (uid, 'Steven Reynolds', 5,
   'Flawless Roofing was outstanding as a contractor on my roof work. They performed quality work, on time and on budget. I''m retired from construction management and they are as good as it gets!!',
   'google', 26),

  (uid, 'Eric Curtis', 5,
   'My experience with Flawless roofing was great. Rene is a good communicator and was able to answer all my questions. His team was fast and they met all the deadlines we had agreed upon. I do recommend his services.',
   'google', 27),

  (uid, 'instaPix NW', 5,
   'Rene from Flawless roofing did a great job installing a new roof. They are professional and did it in 1.5 days. They were priced fairly. They have all the proper CCB and warranties. They have done a lot of the homes in my neighborhood. I have already recommended them to others.',
   'google', 28),

  (uid, 'Amazon Parker', 3,
   'I left a message, waited a few days for a response. Never got one so I moved on to another company. The ice storm did a lot of damage in all towns surrounding, so I''m sure they were busy.',
   'google', 29),

  (uid, 'Don Sidhu', 5,
   'Punctual and professional. Highly recommended.',
   'google', 30),

  (uid, 'C ES', 5,
   'Rene and his team did a wonderful job on our roof today! They were efficient, professional, and did exactly as needed in 5 hours — tear off included! The cost was well within our budget, the materials guaranteed, and they cleaned up the area around the house very well. We couldn''t be more pleased and would recommend his company for any roofing need.',
   'google', 31),

  (uid, 'Rodrigo Arreola', 5,
   'Five-star review.',
   'google', 32),

  (uid, 'Mary Jones', 5,
   'I had contacted a large well known roofing company and was told that they were 4 to 6 weeks out before they could come help me. I was very worried because I had been told that my skylight was leaking! I was given Flawless Roofing owned by Rene Morales as a solution. Rene was out here within a week! He was on time, very clean and very easy to talk to. He went into my attic and up on my roof and fixed my leak!! I am so relieved! My skylight has a crack in it — now I know its condition and have plenty of time to consider my options. When the time comes, Flawless Roofing will be called by me to upgrade the skylight, flashing around it, and roof elements. Thank you, Rene!',
   'google', 33),

  (uid, 'Amy Sim', 5,
   'Rene & his crew installed a new roof on a home in SE Portland that was built in 1906. Rene addressed unforeseen problems and made sure dry rot areas were taken care of and plywood replaced where needed. The crew was very efficient, wasted no time, and did a great job. Price was very fair. Highly recommend Flawless Roofing!',
   'google', 34),

  (uid, 'Terry Palmer', 5,
   'I contacted Flawless Roofing for moss removal, treatment and gutter cleaning. I could not be more pleased with the services provided. They went above and beyond, caulking my roof vents at no additional cost, and inspecting the entire roof. I would definitely recommend them for your roofing needs.',
   'google', 35),

  (uid, 'Eric Elliott', 5,
   'Rene and crew were excellent. They did complete tear off and new roof of ours and our adjoining neighbor''s roof (Townhomes) with steep pitches, in a day and a half on a Saturday and Sunday morning. On time both days, even getting us done a week early before the rain came. No leaks. Great cleanup both days and the whole crew were very respectful at all times. Price was the best — just a few sheets of underlayment being replaced for a 21 year old roof. Very pleased and I would highly recommend. Flawless was recommended through a friend and Rene was very pleasant to work with.',
   'google', 36),

  (uid, 'Matt Beattie', 5,
   'Rene and his team were great to work with. Excellent customer service and follow through. Very experienced roofing team — thank you!!',
   'google', 37),

  (uid, 'K', 5,
   'Very professional and great quality work. Rene was wonderful. Installed our roof ahead of schedule and his crew worked efficiently and had everything finished the same day. Very good with communication and follow-up. Highly recommend.',
   'google', 38),

  (uid, 'Clayton Brown', 5,
   'The Flawless crew was on time, kept my driveway and yard clean during removal of the old roof, and were courteous and fast. Every crew member knew just what to do, and they worked well as a team. It took the crew one and a half days to remove the old roofing and install the new roof. They use quality materials throughout, and my new roof is better than the original.',
   'google', 39),

  (uid, 'Tiffany Yandt', 5,
   'Rene was great to work with — friendly, professional, very responsive. He and his crew did a great job installing our new roof and changing out our leaky skylight. I''ve already recommended Flawless Roofing to friends and neighbors!',
   'google', 40),

  (uid, 'Jason Wuertz', 5,
   'Rene worked with me and was patient with me throughout the quote and contract process. His team showed up on the day scheduled at the time of contracting. He brought a large crew and they knocked out the job of tear off and re-roofing in less than 3 days. All the workers were professional. They cleaned up throughout the day and at the end of each day. The roof looks great. I really enjoyed working with Rene.',
   'google', 41),

  (uid, 'Jim S', 5,
   'Rene and his team reroofed our house. From the initial contact Rene was professional, polite and knowledgeable. His price was competitive, contracts were in order, provided a schedule and showed up as promised. The job site was kept clean and neat. I highly recommend Flawless Roofing for your project.',
   'google', 42),

  (uid, 'Don Rogie', 5,
   'Flawless Roofing did an excellent job installing my new roof and Rene was very professional and great to work with!',
   'google', 43),

  (uid, 'lee chidester', 5,
   'We selected another company for our roofing project but had not heard back from them despite several follow up calls. Rene and his team were working on several homes in the neighborhood so we reached out to request a bid. He matched the bid we previously received and set a date for early fall but was then able to move the project up and take care of the whole thing while we were on vacation. Rene communicated through phone calls and texts throughout the process to ensure we were satisfied. Great customer service from start to finish.',
   'google', 44),

  (uid, 'Richard List', 5,
   'Like several others in our neighborhood, Rene and Flawless came highly recommended. We are thrilled with the customer service, responsiveness and overall professionalism of the crew. They went above and beyond to meet some specific requests, and we felt the components and materials used are better than the competition at a fair price.',
   'google', 45),

  (uid, 'Janet Robrecht', 5,
   'I can''t say enough good things about Flawless Roofing and Rene. When I first reached out I had a leak and felt desperate. I called three companies to get quotes (Rene came recommended from a couple of friends in my neighborhood). He got out his ladder, climbed on my roof and sealed my leak! He told me it was going to be fine and there was no need to spend money on repairing it. My husband and I were thrilled and impressed with his customer service. Before we even got his bid we felt like he was the one. Then when his bid came in under the other companies we KNEW we made the right decision. We are very happy with our new roof and know if we ever have a problem Rene will get it done! He feels like a friend.',
   'google', 46),

  (uid, 'Tess Diaz', 5,
   'Did a great job for a great price!',
   'google', 47),

  (uid, 'Don Corcoran', 5,
   'Rene and his team did a great job cleaning my roof and gutters. Overall very happy and will most definitely hire them again for my roof maintenance.',
   'google', 48),

  (uid, 'Stuart Butsch', 5,
   'Had my roof replaced recently and pleased with the results. Finished quickly, fair price. Would definitely recommend Flawless Roofing.',
   'google', 49),

  (uid, 'John', 5,
   'We are very pleased with everything from start to finish with Flawless Roofing. Their company name says it all. The entire crew did an excellent job, and we would recommend them for any roofing needs you might have. Thanks Rene!',
   'google', 50),

  (uid, 'Rodolfo Garcia', 5,
   'Great experience working with Rene and his team from start to finish. They take care of your every need beyond expectations. Great team — they are fast and good at what they do. Will definitely recommend to my family and friends.',
   'google', 51),

  (uid, 'R J', 5,
   'Punctual, quality work, and professional.',
   'google', 52),

  (uid, 'Tony D', 5,
   'I was very impressed with Rene and his team. Very professional, they worked very clean. I will be using their experience for future jobs. We definitely recommend — thanks guys.',
   'google', 53),

  (uid, 'joey Quintero', 5,
   'Quality work, professional, and great value.',
   'google', 54),

  (uid, 'Hilary Smith', 5,
   'I thoroughly enjoyed working with Rene and his team. They were all very honest, professional, kind and kept me in the loop with the progress and what to expect. They started on time each day, worked extremely diligently and when they were done not even a discarded nail was to be found. I highly recommend Flawless Roofing! A fantastic company!!',
   'google', 55),

  (uid, 'Sheri Krinsky', 5,
   'Rene Morales is an excellent businessman who I would trust to have any roofing project assessed and completed. He is honest, punctual and professional. We were very impressed with him!!',
   'google', 56),

  (uid, 'Ariana Brambila', 5,
   'Great quality work.',
   'google', 57),

  (uid, 'Steve Finch', 5,
   'I was referred to Rene and Flawless Roofing from a neighbor who used them for a reroof. I could not have been happier with Flawless. The customer service, price, and work from start to finish was outstanding. Rene provided me several options for the roof as well as building materials.',
   'google', 58),

  (uid, 'Anne Olson-Murphy', 5,
   'Best experience I could ask for! From the first estimate to the final cleanup, Flawless Roofing exceeded my expectations! The entire crew was friendly and treated my home with respect. The job site was immaculate and my new roof is beautiful. I was also kept updated throughout the process so I knew what to expect from material delivery through the finished product. I highly recommend Flawless Roofing!',
   'google', 59),

  (uid, 'S Clencrew', 5,
   'Rene & team are hard working and reliable. They do a great job and offer competitive pricing. We were very happy with their work and have been happy with the maintenance services we have received. We would definitely recommend Flawless Roofing. They have done many of our neighbors'' homes as well.',
   'google', 60),

  (uid, 'Thomas Durkin', 5,
   'Awesome roofing team. They don''t mess around getting a job done. Good communication and on time.',
   'google', 61),

  (uid, 'Steve Kuske', 5,
   'Rene was great to work with! He quoted a reasonable price and did way more than what he said he would. He''s a kind and pleasant person to work with. I recommend him and his company without reservation.',
   'google', 62),

  (uid, 'Nicolby Atallah', 5,
   'Flawless Roofing is the best! Best customer service and keeps you updated on every step of the project! Highly recommend as they are the best! Thank you Flawless Roofing!',
   'google', 63),

  (uid, 'Tabatha Centeno', 5,
   'Did a great job on my roof and would definitely recommend them to anyone looking! Great customer service!',
   'google', 64),

  (uid, 'Miguel Perez', 5,
   'Great quality of work at an affordable price with good customer service. Give them a call for your roofing needs.',
   'google', 65),

  (uid, 'Rigo Morales', 5,
   'Always gets the job done right and the experience is a big plus. They got you covered from beginning to end. Highly recommended for anyone looking for a new roof or repairs.',
   'google', 66),

  (uid, 'Me I', 5,
   'Did an amazing job at my house, on schedule. Would definitely recommend — fast, friendly, reliable and professional.',
   'google', 67),

  (uid, 'Sarai Valverde', 5,
   'High-quality work at a great price! Highly recommend!',
   'google', 68),

  (uid, 'Debby Pease', 5,
   'We had an awesome experience with everyone at Flawless Roofing from beginning to end. We could not believe how fast and hard they worked. The quality of the work and products were excellent along with the price!',
   'google', 69),

  (uid, 'Nick La Rue', 5,
   'Five-star review.',
   'google', 70),

  (uid, 'Sonia Arellano', 5,
   'Amazing team! Best Roofing company in the Northwest — great prices and quality!',
   'google', 71),

  (uid, 'DeAnn Duncan', 5,
   'I couldn''t be more impressed with Flawless Roofing. Hard working professionals. From the estimate to cleanup, it truly was Flawless. I highly recommend them!!!! So impressed with my roofing experience and quality.',
   'google', 72),

  (uid, 'Jerry & Lynn Andrews', 5,
   'Five-star review.',
   'google', 73),

  (uid, 'Sally Kunz', 5,
   'This was the second roof on two different houses this company has done for us and our roof once again looks so much better! They were super fast and always very professional.',
   'google', 74),

  (uid, 'Chi Nelson', 5,
   'I was impressed by the professionalism and workmanship of the crew. They got our roofing done in one weekend and we are very happy with our new roof! I highly recommend Flawless Roofing & Construction to anyone who is considering getting their roof done.',
   'google', 75),

  (uid, 'Bong Pov', 5,
   'Five-star review.',
   'google', 76),

  (uid, 'Miguel Arellano', 5,
   'Five-star review for roof repair and installation.',
   'google', 77);

END $$;
