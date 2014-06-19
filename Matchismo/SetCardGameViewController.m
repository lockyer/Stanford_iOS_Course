//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Robert Lockyer on 2014-06-17.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

//overrides abstract parent method
- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

//overrides abstract parent method
- (int)numberOfCardsToMatch
{
    return 3;
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    NSMutableDictionary* attributesDictionary = [[NSMutableDictionary alloc] init];
    if([card isKindOfClass:[SetCard class]]) {
        SetCard* setCard = (SetCard *)card;

        if([setCard.shading isEqualToString:@"open"])
        {
            [attributesDictionary setObject:@8 forKey:NSStrokeWidthAttributeName];
        }
        
        if([setCard.color isEqualToString:@"red"])
        {
            [attributesDictionary setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
        }
        else if([setCard.color isEqualToString:@"green"])
        {
            [attributesDictionary setObject:[UIColor greenColor] forKey:NSForegroundColorAttributeName];
        }
        else if([setCard.color isEqualToString:@"purple"])
        {
            [attributesDictionary setObject:[UIColor purpleColor] forKey:NSForegroundColorAttributeName];
        }
    }
    return [[NSAttributedString alloc] initWithString:(card.isChosen ? card.contents : @"") attributes:attributesDictionary];
}

@end
