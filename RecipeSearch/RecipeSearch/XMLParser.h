//
//  XMLParser.h
//  RecipeApp
//
//  Created by Tristan on 31/08/13.
//  Copyright (c) 2013 Tristan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLParser : NSObject <NSXMLParserDelegate> {
    NSMutableString *currentElementValue;
}

@property (nonatomic, retain) NSMutableArray *recipes;

- (XMLParser *)initXMLParser;

@end
