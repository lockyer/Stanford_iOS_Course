//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Robert Lockyer on 2014-06-17.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(instancetype)init
{
    self = [super init];
    
    if(self){
        for(NSString *symbol in [SetCard validSymbols]){
            for(NSNumber *number in [SetCard validNumbers]){
                for(NSString *shading in [SetCard validShadings]){
                    for(NSString *color in [SetCard validColors]){
                        SetCard* card = [[SetCard alloc] initWithSymbol:symbol
                                                              withNumber:number
                                                            withShading:shading
                                                               andColor:color];
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
