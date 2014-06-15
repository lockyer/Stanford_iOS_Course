//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Robert Lockyer on 2014-06-05.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck*)deck withTargetCount:(int)target;
- (Card *)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (NSArray *)getLastMatches;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) BOOL gameStarted;
@property (nonatomic, readonly) int lastScore;
@property (nonatomic, readonly) BOOL endOfRound;
@end
