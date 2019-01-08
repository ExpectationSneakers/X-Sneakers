//
//  SneakerService.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/3/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//


import UIKit

class SneakerService {
    class func getSneakers(completion: @escaping ([Sneaker]) -> Void){
        
        
        let descriptionJordan3: String = "1987-1988 was an outstanding year for Michael Jordan performance wise. Air Jordan 3 IIIMj won the Slam Dunk contest, All Star MVP, All-Defensive First Team and Defensive Player of the Year. Through all this success, he was wearing the Air Jordan 3.\n Peter Moore (which designed the Air Jordan I and helped on the II) was let go from Nike, as well as Bruce Kilgore. When they had left, Peter and Bruce were trying to convince Michael to leave Nike with them, good thing MJ said no.\nNow Nike needed a new designer to make the Air Jordan III. So they went to world famous Tinker Hatfield. His name is known mainly for designing Air Jordan III-XV, and also making a return on the AJ XXs, but Tinker also designed some really nice Nike’s as well. Tinker and Michael worked hard, talked to each other on what were good ideas, and what could “work”. Air Jordan III HistoryMichael wanted a lightweight shoe, with a lot of durability. So with the Air Jordan 3 they both decided to make them a Mid top, the first mid top to be seen in the Air Jordan line. On the AJ III model Tinker placed the famous jumpman logo on the back of the shoe, and adding in a “elephant print” on the toe box. Also the IIIs were the first AJ to have a visible air-sole unit.\nThe inspirations for the AJ III are AJ I and II, the free throw dunk, an elephant, and last, but not least Michael Jordan. Nike’s selling strategy was simple, and great, they had MJ and Mars Blackmon (Spike Lee). After watching these funny commercials you had to go out and buy yourself a pair.\nIn 1987-1988 when the Air Jordan 3s just released they sold for $100.00. In 1994 when Nike re-released the AJ III they retailed at 105.00, but just like the AJ I and II models, they hit sales racks. In 2001 and 2003 when the Air Jordan III released one more time, the price tag was $100.00."
        
        
        let descriptionJordan2: String = "1985 was a great year, not only because Michael Jordan was rookie of the year and played in the All-Star game, but because the Air Jordan 1‘s were released. MJ With Air Jordan IThe Air Jordan I was the first shoe to be worn in the NBA with multiple colors. Peter Moore was the man behind the Air Jordan 1 (and also helped design the Air Jordan II). When Michael Jordan first looked at the AJ I, his response was “I’m not wearing that shoe. I’ll look like a clown”. With time, the shoe slowly grew on him. The original Air Jordan 1 retailed at $65.00.\n Soon after the release of the Air Jordan I, David Stern (Commissioner of the NBA), banned the most popular shoe of the decade to be worn by MJ. Every time Michael stepped on the court with a pair he would have to pay a couple thousand dollars.\nNike loved this idea so much that they encouraged MJ to wear the shoes, and Nike would pay the fees. In result, Nike gave the the Air Jordan 1 “The shoe banned by the NBA” label. There was 23 different color variations released, and this is not including the three colorways of the Air Jordan I KO. Each AJ I shoe came with two sets of laces which matched the color combo.\nIn 1994 Nike re-released the Air Jordan 1, which retailed for $80.00, but they sold terribly, hitting sales racks for $20.00. In 2001-2003 the Air Jordan Retro I once again was re-released, and in 2004 the Air Jordan 1 low made another appearance."
        
        let descriptionJordanSpizike: String = "The Air Jordan Spizike was made to show appreciation to Mars Blackmon aka Spike Lee. Spike’s part in the rising of the Air Jordan was very crucial. A lot of people may remember the funny commercials Spike Lee’s alias Mars Blackmon from the movie She’s Gotta Have it.\n What makes the Air Jordan Spizikes so special is the fact they are made up of a total of six different Air Jordan’s, the Jordan III (midsole), Jordan IV (Wings), Jordan V (Uppers), Jordan VI (Tongue), Jordan IX (Pull Tab) also every Air Jordan Spizike to release (besides the White/Varsity Red-Classic Green) has the Jordan rising sun logo at the heel which originally release on the Jordan IX, and last but not least the Jordan XX (Laser on the inside liner).\nSo far two pairs have released which the first color way is White/Varsity Red-Classic Green and was a East Coast exclusive. This pair was indeed limited, while only 4032 pairs released, but rumor has it some pairs did release unnumbered. The second color way up is the Black/Varsity Red-Classic Green was a Life Style release and places like Eastbay and sneaker shops with an LS account.\nConfirmed color ways of the Air Jordan Spizikes to release are True Blue, Fire Red, Do the Right Thing inspired and White/Varsity Red-Argon Blue. At the moment a rumor which is turning out every day to be more and more a confirmation is a OG color way will release which is White/Black Cement. This color way of the Air Jordan Spizike is after the Air Jordan IV color way, which was also featured in Spike Lee’s movie “Do the Right Thing” were Buggin Out had his brand new Air Jordan’s scuffed by a pedestrian walking his bike."
        
        
        let size1 = Size(size: "7.0")
        let size2 = Size(size: "6.0")
        let size3 = Size(size: "6.5")
        let size4 = Size(size: "7.5")
     
        let sneaker1 = Sneaker(name: "Jordan III", image: #imageLiteral(resourceName: "Jordan3"), prices: 25.5, genre: "Male", description: descriptionJordan3, sizes: [size1,size3])
        let sneaker2 = Sneaker(name: "Jordan I", image: #imageLiteral(resourceName: "Jordan4"), prices: 35.5, genre: "Male", description: descriptionJordan2, sizes: [size1,size2])
        let sneaker3 = Sneaker(name: "Jordan II", image: #imageLiteral(resourceName: "Versace"), prices: 35.5, genre: "Male", description: descriptionJordan2, sizes: [size1,size4])
        let sneaker4 = Sneaker(name: "Jordan X", image: #imageLiteral(resourceName: "Jordan3"), prices: 45.5, genre: "Male", description: descriptionJordanSpizike, sizes: [size4,size3])
        let sneaker5 = Sneaker(name: "Jordan V", image: #imageLiteral(resourceName: "Jordan1"), prices: 65.5, genre: "Male", description: descriptionJordanSpizike, sizes: [size4])
        let sneaker6 = Sneaker(name: "Jordan IV", image: #imageLiteral(resourceName: "Jordan4"), prices: 5.6, genre: "Male", description: descriptionJordan3, sizes: [size2,size3])
        let sneaker7 = Sneaker(name: "Jordan VI", image: #imageLiteral(resourceName: "Jordan4") , prices: 75.5, genre: "Male", description: descriptionJordan3, sizes: [size2,size4,size2,size4,size2,size4,size2,size4,size2,size4,size2,size4,size2,size4,size2,size4])
        
        
        let sneakersArray = [sneaker1, sneaker2, sneaker3, sneaker4, sneaker5, sneaker6, sneaker7]
        completion(sneakersArray)
    }
}
