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
    
    int suitMatches = 0;
    int rankMatches = 0;
    
    for(int i=0; i<cards.count; ++i){
        PlayingCard* cardA = cards[i];
        for(int j=i+1; j<cards.count; ++j){
            PlayingCard* cardB = cards[j];
            if([cardA.suit isEqualToString:cardB.suit]){
                suitMatches += 1;
            }
            if(cardA.rank == cardB.rank){
                rankMatches += 1;
            }
        }
    }
    
    int suitMatchScore = 0;
    if(suitMatches == otherCards.count)
    {
        suitMatchScore = suitMatches * 4;
    }
    int rankMatchScore = 0;
    if(rankMatches == otherCards.count)
    {
        rankMatchScore = rankMatches * 8;
    }
    
    return suitMatchScore + rankMatchScore;
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
