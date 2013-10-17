//
//  RecipeDetailsViewController.m
//  RecipeSearch
//
//  Created by Tristan on 17/10/13.
//  Copyright (c) 2013 Tristan. All rights reserved.
//

#import "RecipeDetailsViewController.h"
#import "Recipe.h"

@interface RecipeDetailsViewController ()
@end

@implementation RecipeDetailsViewController

#pragma mark - 
#pragma mark - Initialise and Load

// initialise a new RecipeDetailViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

// load up the details about the recipe
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableString *contents = [[NSMutableString alloc] initWithString:@"Ingredients\n\n- "];
    [contents appendString:[[self.recipe.ingre valueForKey:@"description"] componentsJoinedByString:@"\n- "]];
    [contents appendString:@"\n\nMethod\n\n- "];
    [contents appendString:[[self.recipe.methods valueForKey:@"description"] componentsJoinedByString:@"\n\n- "]];
    
    self.textView.text = contents;
    self.titleLabel.text = self.recipe.title;
    self.authorLabel.text = [NSString stringWithFormat:@"By %@", self.recipe.name];
}

// display memory warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
