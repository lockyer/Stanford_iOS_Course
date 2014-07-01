//
//  HighScoreViewController.m
//  Matchismo
//
//  Created by Robert Lockyer on 2014-06-30.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "HighScoreViewController.h"

@interface HighScoreViewController ()
@property (weak, nonatomic) IBOutlet UITextView *highScoreList;
@end

@implementation HighScoreViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
    NSMutableAttributedString* mutableHighScoreList = [[NSMutableAttributedString alloc] init];
    
    NSArray* highScores = [[NSUserDefaults standardUserDefaults] arrayForKey:@"highScores"];
    for(NSDictionary* scoreEntry in highScores)
    {
        NSDate* startingDate = [scoreEntry valueForKey:@"startingDate"];
        NSDate* endingDate = [scoreEntry valueForKey:@"endingDate"];
        NSNumber* score = [scoreEntry valueForKey:@"score"];
        NSString* gameType = [scoreEntry valueForKey:@"gameType"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale:usLocale];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];

        NSString* startingDateString = [dateFormatter stringFromDate:startingDate];
        
        NSNumber* duration = [NSNumber numberWithDouble:[endingDate timeIntervalSinceDate:startingDate]];
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setMaximumFractionDigits:0];
        [numberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
        NSString* durationString = [numberFormatter stringFromNumber:duration];
        
        NSAttributedString* dateLabel = [[NSAttributedString alloc] initWithString:@"Date:("];
        NSAttributedString* startingDateAttributedString = [[NSAttributedString alloc] initWithString:startingDateString];
        NSAttributedString* scoreLabel = [[NSAttributedString alloc] initWithString:@"), Score:"];
        NSAttributedString* scoreAttributedString = [[NSAttributedString alloc] initWithString:score.stringValue];
        NSAttributedString* durationLabel = [[NSAttributedString alloc] initWithString:@", Duration:"];
        NSAttributedString* durationAttributedString = [[NSAttributedString alloc] initWithString:durationString];
        NSAttributedString* newLine = [[NSAttributedString alloc] initWithString:@"\n"];
        
        [mutableHighScoreList appendAttributedString:dateLabel];
        [mutableHighScoreList appendAttributedString:startingDateAttributedString];
        [mutableHighScoreList appendAttributedString:scoreLabel];
        [mutableHighScoreList appendAttributedString:scoreAttributedString];
        [mutableHighScoreList appendAttributedString:durationLabel];
        [mutableHighScoreList appendAttributedString:durationAttributedString];
        [mutableHighScoreList appendAttributedString:[[NSAttributedString alloc] initWithString:@"s, Type:"]];
        [mutableHighScoreList appendAttributedString:[[NSAttributedString alloc] initWithString:gameType]];
        [mutableHighScoreList appendAttributedString:newLine];
    }
    self.highScoreList.attributedText = mutableHighScoreList;
}

@end
