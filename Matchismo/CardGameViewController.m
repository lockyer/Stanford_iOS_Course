//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Robert Lockyer on 2014-06-01.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic) Deck* deck;
@property (nonatomic, strong) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardCountButton;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) NSMutableArray* history;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if(!_game){
        NSString* title = [self.cardCountButton titleForSegmentAtIndex:self.cardCountButton.selectedSegmentIndex];
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                                            withTargetCount:title.intValue];
    }
    return _game;
}

- (NSMutableArray *)history
{
    if(!_history){
        _history = [[NSMutableArray alloc] init];
    }
    return _history;
}

//Abstract
- (Deck *)createDeck
{
    return nil;
}

- (IBAction)touchCardCountButton
{
    self.game = nil;
}

- (IBAction)touchNewGameButton:(UIButton *)sender
{
    self.game = nil;
    self.history = nil;
    self.historySlider.value = 1;
    [self updateUI];
    [self touchHistorySlider];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (IBAction)touchHistorySlider {
    int index = self.historySlider.value * (self.history.count - 1);
    self.descriptionLabel.text = self.history[index];
    self.descriptionLabel.alpha = self.historySlider.value == 1 ? 1 : 0.5;
}

- (void)updateUI
{
    [self.cardCountButton setEnabled:!self.game.gameStarted];
    for(UIButton *cardButton in self.cardButtons){
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card* card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    self.descriptionLabel.text = @"";
    for(Card* card in [self.game getLastMatches])
    {
        self.descriptionLabel.text = [self.descriptionLabel.text stringByAppendingString:card.contents];
    }

    if(self.game.endOfRound){
        if(self.game.lastScore > 0){
            self.descriptionLabel.text = [NSString stringWithFormat:@"Matched %@ for %d points", self.descriptionLabel.text, self.game.lastScore];
        } else if(self.game.lastScore < 0) {
            self.descriptionLabel.text = [NSString stringWithFormat:@"%@ don't match, %d points!", self.descriptionLabel.text, self.game.lastScore];
        }
    }
    [self.history addObject:self.descriptionLabel.text];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

@end
