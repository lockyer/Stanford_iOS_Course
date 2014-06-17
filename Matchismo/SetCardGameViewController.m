//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Robert Lockyer on 2014-06-17.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
