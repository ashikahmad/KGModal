//
//  KGAppDelegate.m
//  KGModal
//
//  Created by David Keegan on 10/5/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import "KGAppDelegate.h"
#import "KGModal.h"

@implementation KGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UIViewController alloc] init];
    self.window.rootViewController.view.backgroundColor = [UIColor colorWithRed:0.441 green:0.466 blue:1.000 alpha:1.000];

    CGRect showButtonRect = CGRectZero;
    showButtonRect.size = CGSizeMake(200, 62);
    showButtonRect.origin.x = round(CGRectGetMidX(self.window.rootViewController.view.bounds)-CGRectGetMidX(showButtonRect));
    showButtonRect.origin.y = CGRectGetHeight(self.window.rootViewController.view.bounds)-CGRectGetHeight(showButtonRect)-10;
    UIButton *showButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    showButton.frame = showButtonRect;
    showButton.autoresizingMask =
    UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    [showButton setTitle:@"Show Modal" forState:UIControlStateNormal];
    [showButton addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.window.rootViewController.view addSubview:showButton];

    [KGModal sharedInstance].responsiveToKeyboard = YES;
    [KGModal sharedInstance].closeButtonType = KGModalCloseButtonTypeRight;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)showAction:(id)sender{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 250)];

    CGRect welcomeLabelRect = contentView.bounds;
    welcomeLabelRect.origin.y = 20;
    welcomeLabelRect.size.height = 20;
    UIFont *welcomeLabelFont = [UIFont boldSystemFontOfSize:17];
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
    welcomeLabel.text = @"Welcome to KGModal!";
    welcomeLabel.font = welcomeLabelFont;
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.shadowColor = [UIColor blackColor];
    welcomeLabel.shadowOffset = CGSizeMake(0, 1);
    [contentView addSubview:welcomeLabel];

    CGRect infoLabelRect = CGRectInset(contentView.bounds, 5, 5);
    infoLabelRect.origin.y = CGRectGetMaxY(welcomeLabelRect)+5;
    infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect) + 50;
    UITextView *infoLabel = [[UITextView alloc] initWithFrame:infoLabelRect];
    infoLabel.text = @"KGModal is an easy drop in control that allows you to display any view "
    "in a modal popup. The modal will automatically scale to fit the content view "
    "and center it on screen with nice animations!";
//    infoLabel.numberOfLines = 6;
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
//    infoLabel.shadowColor = [UIColor blackColor];
//    infoLabel.shadowOffset = CGSizeMake(0, 1);
    [contentView addSubview:infoLabel];
    
    CGFloat btnY = CGRectGetMaxY(infoLabelRect)+5;
    CGFloat btnH = CGRectGetMaxY(contentView.frame)-5 - btnY;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(infoLabelRect.origin.x, btnY, infoLabelRect.size.width, btnH);
    [btn setTitle:@"Close Button Right" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeCloseButtonType:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btn];

    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];
}

-(void) changeCloseButtonType:(id) sender {
    UIButton *btn = (UIButton *) sender;
    KGModal*modal = [KGModal sharedInstance];
    KGModalCloseButtonType type = modal.closeButtonType;
    
    [modal endEditing:NO];
    
    if (KGModalCloseButtonTypeLeft == type) {
        modal.closeButtonType = KGModalCloseButtonTypeRight;
        [btn setTitle:@"Close Button Right" forState:UIControlStateNormal];
    } else if(KGModalCloseButtonTypeRight == type){
        modal.closeButtonType = KGModalCloseButtonTypeNone;
        [btn setTitle:@"Close Button None" forState:UIControlStateNormal];
    } else {
        modal.closeButtonType = KGModalCloseButtonTypeLeft;
        [btn setTitle:@"Close Button Left" forState:UIControlStateNormal];
    }
}

@end
