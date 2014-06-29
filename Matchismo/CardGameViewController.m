//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Robert Lockyer on 2014-06-01.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "HistoryViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic) Deck* deck;
@property (nonatomic, strong) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) NSMutableArray* history;
@end

@implementation CardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.descriptionLabel.attributedText = [[NSAttributedString alloc] init];
    [self newGame];
    [self updateUI];
}

- (void)newGame
{
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                                            withTargetCount:[self numberOfCardsToMatch]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Show Set History"] || [segue.identifier isEqualToString:@"Show Playing Card History"])
    {
        if([segue.destinationViewController isKindOfClass:[HistoryViewController class]])
        {
            HistoryViewController* hvc = (HistoryViewController*)segue.destinationViewController;
            hvc.history = self.history;
        }
    }
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

- (IBAction)touchNewGameButton:(id)sender {
    [self newGame];
    self.history = nil;
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card* card = [self.game cardAtIndex:cardIndex];
        NSAttributedString* title = [self titleForCard:card ignoreChosen:NO];
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
        [mutableAttributedText appendAttributedString:[self titleForCard:card ignoreChosen:YES]];
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
    [self.history addObject:self.descriptionLabel.attributedText];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSAttributedString *)titleForCard:(Card *)card ignoreChosen:(BOOL)ignoreChosen
{
    return [[NSAttributedString alloc] init];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

@end
