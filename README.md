# ruby_tokenizer_nlp_poc
This is not meant to be used in the real world. It's merely a proof of concept for phrase tokenization in the spirit of NLP. However, I really enjoyed building this POC, and will evaluate turning this proof of concept into an open source NLP &amp; Machine Learning ruby library

## dependencies ##
made with ruby 2.6.0 , there's no Gemfile, it's just a local script. You'll need a unix based system, Mac or Linux, that's setup for Ruby programming. YEAH. RUBY. I know we got so many haters! I love the language and it's flexibility. People always assume the worst in terms of performance speed in ruby. You really need to examine the various use cases and understand if a few milliseconds are really worth abandoning a certain language and/or framework. It's not always about bench marking. I'd rather have a system that gets the job done and also is easy to use and undertand, and enables me to focus on my idea / application. Na Mean?? (ok - rant over)
` brew install redis && redis-server`
` gem install redis && gem install redis-namespace && gem install nokogiri && gem install activesupport && gem install pry`

### What does this thing do? ###
In a nutshell the class `::Phrase::Tokenizer.new('some cool phrase')` can take any phrase, break the phrase into fragments, and then build every permuation of the fragments from left to right. Each permutation would be a "Token". For example these fragments would be `["some", "cool", "phrase"]`. Each Fragment gets initialized as a `Phrase::Tokenizer::Fragement`.  Each permutation from left to right would be `["some", "some cool", "some cool phrase", "cool", "cool phrase", "phrase"]`. Each permutation is initialized as a `Phrase::Tokenizer::Token`. 

### Why do you care? ###
Well you might not ;) - but if you are trying to do some NLP in ruby then you might. The power of this POC is that, it initializes fragments which essentially are the individual words into ruby objects `Phrase::Tokenizer::Fragement`. This object does some processing and can determine things like parts of speech. Now as Fragments get grouped together, those are tokens, `Phrase::Tokenizer::Token` . Here in the token you can do additonal analysis and start to break down the phrase structure, and analyze the nouns, verbs, adjectives etc. in relation to one another. 

### conclusion ###
For now, the POC tokenizes and determines parts of speech. In my next iteration I will develop a mini ML framework to detect intents, entities, and perhaps enable some action_handler to execute upon certain conditions. This conesquently is ending up to be it's own mini NLP and machine learning library. If I'm happy with my initial results I will push to make this a nice open source NLP & ML library. If any of this makes sense to you and you want to help please reach out! email: bunnarith.bao@gmail.com or twitter @geek_level_1000   
