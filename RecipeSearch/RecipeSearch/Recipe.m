//
//  Recipe.m
//  RecipeApp
//
//  Created by Tristan on 11/10/13.
//  Copyright (c) 2013 Tristan. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

// initialise recipe
- (id)init {
    self = [super init];
    
    _ingre = [[NSMutableArray alloc] init];         // ingredients. 
    _methods = [[NSMutableArray alloc] init];
    _ingredientTags = [[NSMutableArray alloc] init];
    //_nutrition = [[NSMutableArray alloc] init];
    
    return self;
}

@end
