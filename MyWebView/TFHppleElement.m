//
//  TFHppleElement.m
//  Hpple
//
//  Created by Geoffrey Grosenbach on 1/31/09.
//
//  Copyright (c) 2009 Topfunky Corporation, http://topfunky.com
//
//  MIT LICENSE
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#import "TFHppleElement.h"

NSString * const TFHppleNodeContentKey           = @"nodeContent";
NSString * const TFHppleNodeNameKey              = @"nodeName";
NSString * const TFHppleNodeAttributeArrayKey    = @"nodeAttributeArray";
NSString * const TFHppleNodeAttributeNameKey     = @"attributeName";
NSString * const TFHppleNodeAttributeContentKey  = @"attributeContent";
NSString * const TFHppleNodeChildArrayKey        = @"nodeChildArray";

@implementation TFHppleElement

- (void) dealloc
{
  [node release];

  [super dealloc];
}

- (id) initWithNode:(NSDictionary *) theNode
{
  if (!(self = [super init]))
    return nil;

  [theNode retain];
  node = theNode;

  return self;
}


- (NSString *) content
{
  return [node objectForKey:TFHppleNodeContentKey];
}

- (NSArray *)childNodes
{
	NSMutableDictionary *translatedChildren = [NSMutableDictionary dictionary];
	for (NSDictionary *childDict in [node objectForKey: TFHppleNodeChildArrayKey]) 
	{
		[translatedChildren setObject: childDict
							   forKey: [childDict objectForKey: TFHppleNodeNameKey]];
	}
	return [node objectForKey: TFHppleNodeChildArrayKey];
}

- (BOOL) hasChildren
{
	NSArray *childs = [node objectForKey: TFHppleNodeChildArrayKey];
	
	if (childs) 
	{
		return  YES;
	}
	
	return  NO;
}

- (NSArray *) children
{
    if ([self hasChildren])
        return [node objectForKey: TFHppleNodeChildArrayKey];
    return nil;
}


- (NSString *) tagName
{
  return [node objectForKey:TFHppleNodeNameKey];
}

- (NSDictionary *) attributes
{
  NSMutableDictionary * translatedAttributes = [NSMutableDictionary dictionary];
  for (NSDictionary * attributeDict in [node objectForKey:TFHppleNodeAttributeArrayKey]) {
    [translatedAttributes setObject:[attributeDict objectForKey:TFHppleNodeAttributeContentKey]
                             forKey:[attributeDict objectForKey:TFHppleNodeAttributeNameKey]];
  }
  return translatedAttributes;
}

- (NSString *) objectForKey:(NSString *) theKey
{
  return [[self attributes] objectForKey:theKey];
}

- (id) description
{
  return [node description];
}

@end
