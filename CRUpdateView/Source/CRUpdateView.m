//
//  CRUpdateView.m
//  CRUpdateView
//
//  Created by Corey Roberts on 11/9/14.
//  Copyright (c) 2014 Corey Roberts. All rights reserved.
//

#import "CRUpdateView.h"

@interface CRUpdateView()

// iOS 8 Only.
@property (nonatomic, strong) UIVisualEffectView *blurView;
@property (nonatomic, strong) UIVisualEffectView *vibrancyEffectView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *updateOneLabel;
@property (nonatomic, strong) UILabel *updateTwoLabel;
@property (nonatomic, strong) UILabel *updateThreeLabel;
@property (nonatomic, strong) UIImageView *updateOneImage;
@property (nonatomic, strong) UIImageView *updateTwoImage;
@property (nonatomic, strong) UIImageView *updateThreeImage;
@property (nonatomic, strong) UIButton *confirmationButton;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation CRUpdateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // if iOS 8
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _blurView.translatesAutoresizingMaskIntoConstraints = NO;
        _blurView.hidden = YES;
        
        [self addSubview:_blurView];
        
        // Vibrancy.
        UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
        _vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
        _vibrancyEffectView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.text = @"What's new?";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:32];
        
        [_vibrancyEffectView.contentView addSubview:_titleLabel];
        
        _updateOneLabel = [UILabel new];
        _updateTwoLabel = [UILabel new];
        _updateThreeLabel = [UILabel new];
        
        _updateOneImage = [UIImageView new];
        _updateTwoImage = [UIImageView new];
        _updateThreeImage = [UIImageView new];
        
        for (UILabel *label in @[ _updateOneLabel, _updateTwoLabel, _updateThreeLabel ]) {
            label.translatesAutoresizingMaskIntoConstraints = NO;
            label.font = [UIFont systemFontOfSize:20];
            label.text = @"Here's an update.";
            label.numberOfLines = 0;
//            label.backgroundColor = [UIColor whiteColor];
            
            [_vibrancyEffectView.contentView addSubview:label];
        }
        
        for (UIImageView *imageView in @[ _updateOneImage, _updateTwoImage, _updateThreeImage ]) {
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.image = [UIImage imageNamed:@"CheckboxIcon"];
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            
            [_vibrancyEffectView.contentView addSubview:imageView];
        }
        
        _confirmationButton = [UIButton new];
        _confirmationButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_confirmationButton addTarget:self action:@selector(confirmationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmationButton setTitle:@"Sweet, bro." forState:UIControlStateNormal];
        
        [_vibrancyEffectView.contentView addSubview:_confirmationButton];
        
        
        [_blurView.contentView addSubview:_vibrancyEffectView];
        
        // Constraints.
        NSDictionary *metrics = @{
                                  @"padding" : @20,
                                  @"imagePadding" : @40,
                                  @"verticalPadding" : @64,
                                  @"defaultHeight" : @60,
                                  @"confirmButtonSize" : @24
                                  };
        NSDictionary *views = @{
                                @"blurView" : _blurView,
                                @"vibranceView" : _vibrancyEffectView,
                                @"titleLabel" : _titleLabel,
                                @"updateOneLabel" : _updateOneLabel,
                                @"updateTwoLabel" : _updateTwoLabel,
                                @"updateThreeLabel" : _updateThreeLabel,
                                @"imageViewOne" : _updateOneImage,
                                @"imageViewTwo" : _updateTwoImage,
                                @"imageViewThree" : _updateThreeImage,
                                @"confirmButton" : _confirmationButton
                                 };
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[blurView]|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[blurView]|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[vibranceView]|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[vibranceView]|" options:0 metrics:metrics views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-padding-[titleLabel]-padding-|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-verticalPadding-[titleLabel(defaultHeight)]-padding-[updateOneLabel(defaultHeight)]-padding-[updateTwoLabel(defaultHeight)]-padding-[updateThreeLabel(defaultHeight)]" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel]-padding-[imageViewOne(defaultHeight)]-padding-[imageViewTwo(defaultHeight)]-padding-[imageViewThree(defaultHeight)]" options:0 metrics:metrics views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-padding-[imageViewOne(defaultHeight)]-padding-[updateOneLabel]-padding-|" options:0 metrics:metrics views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-padding-[imageViewTwo(defaultHeight)]-padding-[updateTwoLabel]-padding-|" options:0 metrics:metrics views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-padding-[imageViewThree(defaultHeight)]-padding-[updateThreeLabel]-padding-|" options:0 metrics:metrics views:views]];
        
        // Confirmation Button.
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[confirmButton(confirmButtonSize)]-padding-|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-padding-[confirmButton]-padding-|" options:0 metrics:metrics views:views]];

    }
    
    return self;
}

- (void)setUpdateTitleString:(NSString *)updateTitleString {
    self.titleLabel.text = updateTitleString;
}

- (void)setFirstUpdateString:(NSString *)firstUpdateString {
    self.updateOneLabel.text = firstUpdateString;
}

- (void)setSecondUpdateString:(NSString *)secondUpdateString {
    self.updateTwoLabel.text = secondUpdateString;
}

- (void)setThirdUpdateString:(NSString *)thirdUpdateString {
    self.updateThreeLabel.text = thirdUpdateString;
}

- (void)setFirstUpdateImage:(UIImage *)firstUpdateImage {
    self.updateOneImage.image = firstUpdateImage;
}

- (void)setSecondUpdateImage:(UIImage *)secondUpdateImage {
    self.updateTwoImage.image = secondUpdateImage;
}

- (void)setThirdUpdateImage:(UIImage *)thirdUpdateImage {
    self.updateThreeImage.image = thirdUpdateImage;
}

#pragma mark - Public Methods

- (void)display {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.blurView.hidden = NO;
    self.blurView.alpha = 0.0;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.blurView.alpha = 1.0;
    }];
}

#pragma mark - Private Methods

- (void)confirmationButtonPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(userDidPressConfirmationButton)]) {
        [self.delegate userDidPressConfirmationButton];
    }
    
    // Revoke view.
    [self revokeView];
}

- (void)revokeView {
    [UIView animateWithDuration:0.5 animations:^{
        self.blurView.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.blurView.hidden = YES;
    }];
}

@end
