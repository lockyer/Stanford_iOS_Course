//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Robert Lockyer on 2014-06-16.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

//overrides abstract parent method
- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

//overrides abstract parent method
- (int)numberOfCardsToMatch
{
    return 2;
}

- (NSAttributedString *)titleForCard:(Card *)card ignoreChosen:(BOOL)ignoreChosen
{
    NSString* contents = card.contents;
    if(!ignoreChosen && !card.chosen){
        contents = @"";
    }
    UIColor* color = [UIColor blackColor];
    if([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard* playingCard = (PlayingCard*)card;
        if([@[@"♥︎", @"♦︎"] containsObject:playingCard.suit]){
            color = [UIColor redColor];
        }
    }
    return [[NSAttributedString alloc] initWithString:contents attributes:@{NSForegroundColorAttributeName : color }];
}

- (NSString *)titleForGame
{
    return @"Cards";
}

@end
