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

- (NSAttributedString *)titleForCard:(Card *)card ignoreChosen:(BOOL)ignoreChosen
{
    NSMutableDictionary* attributesDictionary = [[NSMutableDictionary alloc] init];
    NSString* outputString = @"";
    if([card isKindOfClass:[SetCard class]]) {
        SetCard* setCard = (SetCard *)card;
        
        for(int i=0; i<setCard.number.intValue; ++i){
            outputString = [outputString stringByAppendingString:setCard.symbol];
        }

        float alpha = 1;
        
        if([setCard.shading isEqualToString:@"open"])
        {
            [attributesDictionary setObject:@8 forKey:NSStrokeWidthAttributeName];
        }
        else if([setCard.shading isEqualToString:@"striped"])
        {
            alpha = 0.2f;
        }
        else if([setCard.shading isEqualToString:@"solid"])
        {
            alpha = 1;
        }
        
        if([setCard.color isEqualToString:@"red"])
        {
            [attributesDictionary setObject:[UIColor colorWithRed:1 green:0 blue:0 alpha:alpha] forKey:NSForegroundColorAttributeName];
        }
        else if([setCard.color isEqualToString:@"green"])
        {
            [attributesDictionary setObject:[UIColor colorWithRed:0 green:1 blue:0 alpha:alpha] forKey:NSForegroundColorAttributeName];
        }
        else if([setCard.color isEqualToString:@"purple"])
        {
            [attributesDictionary setObject:[UIColor colorWithRed:1 green:0 blue:1 alpha:alpha] forKey:NSForegroundColorAttributeName];
        }
    }
    return [[NSAttributedString alloc] initWithString:outputString attributes:attributesDictionary];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"SetChosen" : @"cardFront"];
}

- (NSString *)titleForGame
{
    return @"Set";
}

@end
