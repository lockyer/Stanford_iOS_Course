//
//  SetCard.h
//  Matchismo
//
//  Created by Robert Lockyer on 2014-06-17.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
- (instancetype)initWithSymbol:(NSString*)symbol
                     withNumber:(NSNumber*)number
                   withShading:(NSString*)shading
                      andColor:(NSString*)color;

@property (nonatomic, readonly) NSNumber* number;
@property (nonatomic, readonly) NSString* symbol;
@property (nonatomic, readonly) NSString* shading;
@property (nonatomic, readonly) NSString* color;

+ (NSArray *)validNumbers;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;
@end
