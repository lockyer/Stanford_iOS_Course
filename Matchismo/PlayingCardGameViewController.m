//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Robert Lockyer on 2014-06-16.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
