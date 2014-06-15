//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Robert Lockyer on 2014-06-05.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@property (nonatomic, readwrite) int numberOfCardsToMatch;
@property (nonatomic, readwrite) BOOL gameStarted;
@property (nonatomic, readwrite) int lastScore;
@property (nonatomic, readwrite) NSMutableArray* lastMatches;
@property (nonatomic, readwrite) BOOL endOfRound;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)lastMatches
{
    if(!_lastMatches) _lastMatches = [[NSMutableArray alloc] init];
    return _lastMatches;
}

- (NSArray *)getLastMatches
{
    return self.lastMatches;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck*)deck
                        withTargetCount:(int)target
{
    self = [super init];
    
    if(self){
        self.numberOfCardsToMatch = target;
        self.gameStarted = NO;
        for (int i=0; i<count; i++){
            Card* card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }
            else{
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (Card *)chooseCardAtIndex:(NSUInteger)index
{
    self.endOfRound = NO;
    self.gameStarted = YES;
    self.lastScore = 0;
    Card* card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        [self.lastMatches removeAllObjects];
        for(Card *otherCard in self.cards){
            if(otherCard.isChosen && !otherCard.isMatched){
                [self.lastMatches addObject:otherCard];
            }
        }
        
        if(card.isChosen) {
            card.chosen = NO;
            [self.lastMatches removeObject:card];
        } else {
            if(self.lastMatches.count == self.numberOfCardsToMatch - 1)
            {
                self.endOfRound = YES;
                int matchScore = [card match:self.lastMatches];
                if(matchScore){
                    self.lastScore += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for(Card* otherCard in self.lastMatches)
                    {
                        otherCard.matched = YES;
                    }
                } else {
                    self.lastScore -= MISMATCH_PENALTY;
                    for(Card* otherCard in self.lastMatches)
                    {
                        otherCard.chosen = NO;
                    }
                }
            }
            [self.lastMatches addObject:card];
            self.lastScore -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    
    self.score += self.lastScore;
    return card;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (instancetype)init
{
    return nil;
}

@end
