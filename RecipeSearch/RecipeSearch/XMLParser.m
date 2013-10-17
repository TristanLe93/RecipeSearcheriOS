//
//  XMLParser.m
//  RecipeApp
//
//  Created by Tristan on 31/08/13.
//  Copyright (c) 2013 Tristan. All rights reserved.
//

#import "XMLParser.h"
#import "Recipe.h"
#import <objc/runtime.h>

@interface XMLParser () {
    Recipe *recipe;
    NSMutableArray *propertyNames;
    NSString *currentTag;
}

@end

@implementation XMLParser
@synthesize recipes;

// initialise recipes array and ManageObjectContext from AppDelegate
- (XMLParser *)initXMLParser {
    recipes = [[NSMutableArray alloc] init];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([Recipe class], &count);
    propertyNames = [[NSMutableArray alloc] init];
    
    for (int i =0; i < count; i++) {
        NSString *name = [NSString stringWithUTF8String:property_getName(properties[i])];
        [propertyNames addObject:name];
    }
    
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"recipe"])
        recipe = [[Recipe alloc] init];
    
    currentElementValue = nil;
}


// when we reach the end tag, store the data to its respective object.
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"%@", elementName);
    if ([elementName isEqualToString:@"recipe"]) {
        [recipes addObject:recipe];
        recipe = nil;
    }
    
    if ([elementName isEqualToString:@"label"])
        [recipe.ingre addObject:currentElementValue];
    
    else if ([elementName isEqualToString:@"step"])
        [recipe.methods addObject:currentElementValue];
    
    else if ([elementName isEqualToString:@"baseingredient"])
        [recipe.ingredientTags addObject:currentElementValue];

    else if ([self isElementInPropertyList:elementName])
        [recipe setValue:currentElementValue forKey:elementName];
}

// store the element value to currentElementValue
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSString *value = [string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (!currentElementValue)
        currentElementValue = [[NSMutableString alloc] initWithString:value];
    else
        [currentElementValue appendString:value];
}


- (BOOL)isElementInPropertyList:(NSString *)elementName {
    return [propertyNames containsObject:elementName];
}

@end
