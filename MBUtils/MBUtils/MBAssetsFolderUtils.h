//
//  MBAssetsFoldersUtils.h
//  MBUtils
//
//  Created by Matteo Battistini on 29/06/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBAssetsFolderUtils : NSObject

+ (NSURL *) getDocumetFolder:(NSString *)string;
+ (void) createDocumentFolder:(NSString *)folderName;
+ (void) removeDocumentFolder:(NSString *)folderName;
+ (NSArray *) getContentsOfDocumentFolder:(NSString *)folderName;
+ (NSArray *) getContentsOfDocumentFolder:(NSString *)folderName withExtension:(NSString *)extension;
+ (NSArray *) getContentsPathOfDocumentFolder:(NSString *)folderName;
+ (NSArray *) getContentsPathOfDocumentFolder:(NSString *)folderName withExtension:(NSString *) extension;

@end
