//
//  LSIBANRoundDevidedButton.m
//  IBAN
//
//  Created by Lukas Schmidt on 24.06.14.
//  Copyright (c) 2014 Lukas Schmidt. All rights reserved.
//

#import "LSIBANRoundDevidedButton.h"
#import "UIImage+MonoImage.h"
#import "UIColor+IBANColors.h"

@implementation LSIBANRoundDevidedButton

- (void)setButtonsWithLeftButtonSelector:(SEL)leftSelector
                     rightButtonSelector:(SEL)rightSelector
                                  target:(id)target
{
    [super setButtonsWithLeftButtonSelector:leftSelector rightButtonSelector:rightSelector target:target];
    [self setupLeftButtonImages];
    [self setupRightButtonImages];
}

- (void)setupLeftButtonImages
{
    [self.leftButton setImage:[[UIImage imageNamed:@"glyphicons_048_dislikes.png"] imageWithOverlayColor:[UIColor buttonFavoriteStarColor]] forState:UIControlStateNormal];
    
    [self.leftButton setImage:[[UIImage imageNamed:@"glyphicons_048_dislikes.png"] imageWithOverlayColor:[UIColor buttonDeactivatedColor]] forState:UIControlStateDisabled];

    [self.leftButton setImage:[[UIImage imageNamed:@"glyphicons_049_star.png"] imageWithOverlayColor:[UIColor buttonFavoriteStarColor]] forState:UIControlStateSelected];
    
}

- (void)setupRightButtonImages
{
    [self.rightButton setImage:[UIImage imageNamed:@"copyTrans.png"] forState:UIControlStateNormal];
    
    [self.rightButton setImage:[[UIImage imageNamed:@"copyTrans.png"] imageWithOverlayColor:[UIColor buttonDeactivatedColor]] forState:UIControlStateDisabled];
}

- (void)animateLeftStar:(BOOL)isFavAnimation
              shouldPop:(BOOL)shouldPop
{
    //TODO: Make use of iOS 8 Spring Animation
    if (isFavAnimation) {
        [UIView animateWithDuration:0.2
                              delay:0.18
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [self.leftButton setSelected:YES];
                             if (shouldPop) {
                                 self.leftButton.transform = CGAffineTransformMakeScale(2.5,2.5);
                             }
                         }
                         completion:^(BOOL finisehd){
                             if (finisehd) {
                                 [UIView animateWithDuration:0.2
                                                       delay:0
                                                     options:UIViewAnimationOptionCurveEaseOut
                                                  animations:^{
                                                      [self.leftButton setSelected:YES];
                                                      if (shouldPop) {
                                                          self.leftButton.transform = CGAffineTransformMakeScale(1,1);
                                                      }
                                                  }
                                                  completion:nil];
                             }
                         }];
    } else{
        [self.leftButton setSelected:NO];
    }
    
}


@end