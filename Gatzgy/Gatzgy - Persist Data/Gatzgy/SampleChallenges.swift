//
//  SampleChallenges.swift
//  Gatzgy
//
//  Created by Diego Covarrubias on 12/5/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import Foundation

struct sampleChallenges {
    
    static let photo1 = UIImage(named: "New Vocab")!
    static let challenge1 = Challenge(title: "New Vocab", photo: photo1, descript: "It's time to learn some new words! Visit urbandictionary.com, pick a new word, and try to slip it into a casual conversation. Good luck!")!
    
    static let photo2 = UIImage(named: "Holiday")!
    static let challenge2 = Challenge(title: "Happy Holidays", photo: photo2, descript: "If you search hard enough, everyday is a holiday! Find a wacky one and celebrate it with the ones you love. (Google will help)")!
    
    static let photo3 = UIImage(named: "Retry")!
    static let challenge3 = Challenge(title: "One More Time", photo: photo3, descript: "We've all had those experiences that left us saying 'Never again', but today we're going to break that vow. Give that thing one more chance, it might be better than you remember (or a lot worse, but hey, you'll never know if you don't try)")!
    
    static let photo4 = UIImage(named: "Flags")!
    static let challenge4 = Challenge(title: "G'day Mate", photo: photo4, descript: "Did you know I'm from Australia? Well I'm not, but you don't know that and neither does anyone else! Try to speak in an accent of your choosing and see if you can convince someone that it's real.")!
    
    static let photo5 = UIImage(named: "Smores")!
    static let challenge5 = Challenge(title: "S'mores", photo: photo5, descript: "How long has it been since you've had your favorite childhood treat? The answer is 'Too long'. Have some fun, make a S'more (or get some cotton candy if you're not into chocolate), it'll be good for your soul.")!
    
    static let photo6 = UIImage(named: "New Music")!
    static let challenge6 = Challenge(title: "New Music", photo: photo6, descript: "Do you find yourself listening to only one or two genres of music? Not today! Pick a new genre (or mulitple) and listen to it for at least an hour today. For a lot of you this will mean country music. Enjoy the blue jeans and pick-up trucks!")!
    
    static let photo7 = UIImage(named: "The Bean")!
    static let challenge7 = Challenge(title: "What a Wonderful World", photo: photo7, descript: "Find something beautiful today and take the time appreciate it.")!
    
    static let photo8 = UIImage(named: "Literate")!
    static let challenge8 = Challenge(title: "Prove It", photo: photo8, descript: "You're literate, right? Maybe we don't have the time to exercise this skill all the time, but today we're going to test it. Find a poem or short story that piques your interest and take some time to reflect.")!
    
    static let photo9 = UIImage(named: "New Friend")!
    static let challenge9 = Challenge(title: "New Friends", photo: photo9, descript: "You know that person that you see pretty much everyday, but never really talk to? Well, today you're going to strike up a conversation and maybe even make a new friend!")!
    
    static let photo10 = UIImage(named: "Weezer CD")!
    static let challenge10 = Challenge(title: "Bargain Hunting", photo: photo10, descript: "Hit up your local thrift store, dollar store, etc. and see what kind of treasures await you. (You don't have to buy anything to have a great time.)")!
    
    static let defaultChallenges = [challenge1, challenge2, challenge3, challenge4, challenge5, challenge6, challenge7, challenge8, challenge9, challenge10]
}
