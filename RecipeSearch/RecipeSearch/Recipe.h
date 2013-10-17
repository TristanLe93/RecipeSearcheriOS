//
//  Recipe.h
//  RecipeApp
//
//  Created by Tristan on 11/10/13.
//  Copyright (c) 2013 Tristan. All rights reserved.
//

@interface Recipe : NSObject

@property (nonatomic, retain) NSString * recipeid;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * name;           // author name
@property (nonatomic, retain) NSString * difficulty;
@property (nonatomic, retain) NSString * rating;
@property (nonatomic, retain) NSString * yield;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * preptime;
@property (nonatomic, retain) NSString * inactivetime;
@property (nonatomic, retain) NSString * cooktime;
@property (nonatomic, retain) NSMutableArray * ingre;
@property (nonatomic, retain) NSMutableArray * methods;
@property (nonatomic, retain) NSMutableArray * ingredientTags;

@end
