//
//  CRUpdateView.h
//  CRUpdateView
//
//  Created by Corey Roberts on 11/9/14.
//  Copyright (c) 2014 Corey Roberts. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CRUpdateViewDelegate <NSObject>

- (void)userDidPressConfirmationButton;

@end

@interface CRUpdateView : UIView

@property (nonatomic, copy) NSString *updateTitleString;

@property (nonatomic, copy) NSString *firstUpdateString;
@property (nonatomic, copy) NSString *secondUpdateString;
@property (nonatomic, copy) NSString *thirdUpdateString;

@property (nonatomic, copy) UIImage *firstUpdateImage;
@property (nonatomic, copy) UIImage *secondUpdateImage;
@property (nonatomic, copy) UIImage *thirdUpdateImage;

@property (nonatomic, assign) id<CRUpdateViewDelegate> delegate;

- (void)display;

@end
