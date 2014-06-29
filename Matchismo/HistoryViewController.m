//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Robert Lockyer on 2014-06-26.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation HistoryViewController

- (void)setHistory:(NSArray *)history
{
    _history = history;
    if(self.view.window) [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
    self.historyTextView.attributedText = [[NSAttributedString alloc] init];
    for(NSAttributedString* historyEntry in self.history)
    {
        NSMutableAttributedString* mutableText = [self.historyTextView.attributedText mutableCopy];
        [mutableText appendAttributedString:historyEntry];
        [mutableText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        self.historyTextView.attributedText = mutableText;
    }
}

@end
