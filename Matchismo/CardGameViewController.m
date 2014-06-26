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
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) NSMutableArray* history;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@end

@implementation CardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.historySlider.enabled = false;
}

- (CardMatchingGame *)game
{
    if(!_game){
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                                            withTargetCount:[self numberOfCardsToMatch]];
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

//Abstract
- (int)numberOfCardsToMatch
{
    return -1;
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
    self.historySlider.enabled = self.game.gameStarted;
    for(UIButton *cardButton in self.cardButtons){
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card* card = [self.game cardAtIndex:cardIndex];
        NSAttributedString* title = card.isChosen ? [self titleForCard:card] : [[NSAttributedString alloc] init];
        [cardButton setAttributedTitle:title
                              forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    self.descriptionLabel.attributedText = [[NSAttributedString alloc] init];
    for(Card* card in [self.game getLastMatches])
    {
        NSMutableAttributedString* mutableAttributedText = [self.descriptionLabel.attributedText mutableCopy];
        [mutableAttributedText appendAttributedString:[self titleForCard:card]];
        self.descriptionLabel.attributedText = mutableAttributedText;
    }

    if(self.game.endOfRound){
        if(self.game.lastScore > 0){
            NSMutableAttributedString* mutableAttributedText = [[NSMutableAttributedString alloc] init];
            [mutableAttributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Matched "]];
            [mutableAttributedText appendAttributedString:self.descriptionLabel.attributedText];
            NSString* pointsString = [NSString stringWithFormat:@" for %d points", self.game.lastScore];
            NSAttributedString* attributedPointsString = [[NSAttributedString alloc] initWithString:pointsString];
            [mutableAttributedText appendAttributedString:attributedPointsString];
            self.descriptionLabel.attributedText = mutableAttributedText;
        } else if(self.game.lastScore < 0) {
            NSMutableAttributedString* mutableAttributedText = [self.descriptionLabel.attributedText mutableCopy];
            [mutableAttributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" don't match, "]];
            NSString* pointsString = [NSString stringWithFormat:@" %d points!", self.game.lastScore];
            NSAttributedString* attributedPointsString = [[NSAttributedString alloc] initWithString:pointsString];
            [mutableAttributedText appendAttributedString:attributedPointsString];
            self.descriptionLabel.attributedText = mutableAttributedText;
        }
    }
    [self.history addObject:self.descriptionLabel.text];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    return [[NSAttributedString alloc] initWithString:(card.isChosen ? card.contents : @"") attributes:@{NSForegroundColorAttributeName : [UIColor blackColor] }];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

@end
