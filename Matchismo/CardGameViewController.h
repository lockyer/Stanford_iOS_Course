//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Robert Lockyer on 2014-06-01.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

//protected, must implement in subclasses
- (Deck *)createDeck;
- (int)numberOfCardsToMatch;
- (NSAttributedString *)titleForCard:(Card *)card ignoreChosen:(BOOL)ignoreChosen;
@end
