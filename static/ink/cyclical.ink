-> main

=== main ===
// show 'a difficult battle' only the first time.
{After a difficult battle, you|You} find yourself at a junction. You can enter a courtyard, or traverse the scorched bridge.

+ [Enter the courtyard] -> solaire_encounter
+ [Traverse the bridge] ->
    You are eaten by a grue.
    -> main

=== solaire_encounter ===
// you learn Solaire's name after greeting him.
You enter an open courtyard, and see {greetings: Solaire|a strange man} gazing at the setting sun.

* [Greet him] -> greetings
+ {greetings and not accept} [See what he wanted] -> ask_question
+ {accept} [Talk with him again] -> further_conversation
+ [Leave] -> main

= greetings
Ah, hello! You don't look Hollow, far from it!
I am Solaire of Astora, an adherent of the Lord of Sunlight. Now that I am Undead, I have come to this great land, the birthplace of Lord Gwyn, to seek my very own sun!
… Do you find that strange? Well, you should! No need to hide your reaction. I get that look all the time! Hah hah hah! Oh, ah hah!

* [Continue talking] -> ask_question
* [Leave him alone] -> main

= ask_question

So, I didn't scare you? I have a proposition, if you have a moment. The way I see it, our fates appear to be intertwined. In a land brimming with Hollows, could that really be mere chance? So, what do you say? Why not help one another on this lonely journey?

* [Agree to help him] -> accept
+ [Decline] -> main

= accept

This pleases me greatly!
Well then, take this. We are amidst strange beings, in a strange land. The flow of time itself is convoluted, with heroes centuries old phasing in and out. The very fabric wavers, and relations shift and obscure. There's no telling how much longer your world and mine will remain in contact. But, use this, to summon one another as spirits, cross the gaps between the worlds, and engage in jolly co-operation! Of course, we are not the only one engaged in this. But I am a warrior of the sun! Spot my summon signature easily by its brilliant aura. If you miss it, you must be blind! Hah hah hah!

+ [Leave] -> main

= further_conversation
// use a sequence to show additional conversation options.
{Oh, hello there. I will stay behind, to gaze at the sun. The sun is a wondrous body. Like a magnificent father! If only I could be so grossly incandescent!\
|Oh, there you are. You've been quiet these days. Smooth summoning out there? Anytime you see my brilliantly shining signature, do not hesitate to call upon me. You've left me with quite an impression. I would relish a chance to assist you.\
|You really are fond of chatting with me, aren't you? If I didn't know better, I'd think you had feelings for me! Oh, no, dear me. Pretend you didn't hear that! Hah hah hah!}

+ [Leave] -> main
