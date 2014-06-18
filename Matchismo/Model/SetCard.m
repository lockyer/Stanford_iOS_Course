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
