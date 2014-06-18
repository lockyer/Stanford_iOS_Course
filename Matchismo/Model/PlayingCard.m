//
//  PlayingCard.m
//  Matchismo
//
//  Created by Robert Lockyer on 2014-06-01.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    NSMutableArray* cards = [[NSMutableArray alloc] initWithObjects:self, nil];
    [cards addObjectsFromArray:otherCards];
    
    int suitScore = 0;
    int rankScore = 0;
    
    for(int i=0; i<cards.count; ++i){
        PlayingCard* cardA = cards[i];
        for(int j=i+1; j<cards.count; ++j){
            PlayingCard* cardB = cards[j];
            if([cardA.suit isEqualToString:cardB.suit]){
                suitScore += 1;
            }
            if(cardA.rank == cardB.rank){
                rankScore += 4;
            }
        }
    }
    return suitScore + rankScore;
}

-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *) validSuits
{
    return @[@"♠︎", @"♣︎", @"♥︎", @"♦︎"];
}

-(void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

+(NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+(NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

-(void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}


@end
