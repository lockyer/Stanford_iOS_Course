//
//  SetCard.m
//  Matchismo
//
//  Created by Robert Lockyer on 2014-06-17.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()

@end


@implementation SetCard

- (instancetype)initWithSymbol:(NSString*)symbol
                     withNumber:(NSNumber*)number
                   withShading:(NSString*)shading
                      andColor:(NSString*)color
{
    self = [super init];
    
    if(self){
        if([[SetCard validSymbols] containsObject:symbol])
        {
            _symbol = symbol;
        }
        if([[SetCard validNumbers] containsObject:number])
        {
            _number = number;
        }
        if([[SetCard validShadings] containsObject:shading])
        {
            _shading = shading;
        }
        if([[SetCard validColors] containsObject:color])
        {
            _color = color;
        }
        
        if(!self.symbol || !self.number || !self.shading || !self.color)
        {
            return nil;
        }
    }
    return self;
}

- (int)match:(NSArray *)otherCards
{
    if(otherCards.count != 2) {
        return 0;
    }
    
    SetCard* a = self;
    SetCard* b = otherCards[0];
    SetCard* c = otherCards[1];
    
    //All Match
    if([a.number isEqualToNumber:b.number] && [b.number isEqualToNumber:c.number])
    {
        return 1;
    }
    if([a.symbol isEqualToString:b.symbol] && [b.symbol isEqualToString:c.symbol])
    {
        return 1;
    }
    if([a.shading isEqualToString:b.shading] && [b.shading isEqualToString:c.shading])
    {
        return 1;
    }
    if([a.color isEqualToString:b.color] && [b.color isEqualToString:c.color])
    {
        return 1;
    }
    
    //All Different
    if(![a.number isEqualToNumber:b.number] && ![b.number isEqualToNumber:c.number] && ![c.number isEqualToNumber:a.number])
    {
        return 1;
    }
    if(![a.symbol isEqualToString:b.symbol] && ![b.symbol isEqualToString:c.symbol] && ![c.symbol isEqualToString:a.symbol])
    {
        return 1;
    }
    if(![a.shading isEqualToString:b.shading] && ![b.shading isEqualToString:c.shading] && ![c.shading isEqualToString:a.shading])
    {
        return 1;
    }
    if(![a.color isEqualToString:b.color] && ![b.color isEqualToString:c.color] && ![c.color isEqualToString:a.color])
    {
        return 1;
    }
    
    return 0;
}

- (instancetype)init
{
    return nil;
}

+ (NSArray *)validNumbers
{
    return @[@1,@2,@3];
}

+ (NSArray *)validSymbols
{
    return @[@"▲", @"●", @"◼︎"];
}

+ (NSArray *)validShadings
{
    return @[@"solid", @"striped", @"open"];
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"purple"];
}

- (NSString*)contents
{
    NSString* test = @"";
    for(int i=0; i<self.number.intValue; ++i){
        test = [test stringByAppendingString:self.symbol];
    }
    return test;
}



@end
