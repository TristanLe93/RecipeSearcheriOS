//
//  RecipeDetailsViewController.h
//  RecipeSearch
//
//  Created by Tristan on 17/10/13.
//  Copyright (c) 2013 Tristan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Recipe;

@interface RecipeDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) Recipe *recipe;

@end
