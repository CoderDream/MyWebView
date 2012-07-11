//
//  XPathQuery.m
//  FuelFinder
//
//  Created by Matt Gallagher on 4/08/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "XPathQuery.h"

#import <libxml/tree.h>
#import <libxml/parser.h>
#import <libxml/HTMLparser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>

NSDictionary *DictionaryForNode(xmlNodePtr currentNode, NSMutableDictionary *parentResult) {
  NSMutableDictionary *resultForNode = [NSMutableDictionary dictionary];

  if (currentNode->name)
    {
      NSString *currentNodeContent =
        [NSString stringWithCString:(const char *)currentNode->name encoding:NSUTF8StringEncoding];
      [resultForNode setObject:currentNodeContent forKey:@"nodeName"];
		NSLog(@"node name=%@", currentNodeContent);
    }

  if (currentNode->content && currentNode->content != (xmlChar *)-1)
    {
      NSString *currentNodeContent =
        [NSString stringWithCString:(const char *)currentNode->content encoding:NSUTF8StringEncoding];

      if ([[resultForNode objectForKey:@"nodeName"] isEqual:@"text"] && parentResult)
        {
			//NSString *str = [currentNodeContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			//NSLog(@"text value=%@", str);		 
          [parentResult
            setObject:
              [currentNodeContent
                stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
            forKey:@"nodeContent"];
          return nil;
        }
		//NSLog(@"content=%@", currentNodeContent);
      [resultForNode setObject:currentNodeContent forKey:@"nodeContent"];
    }

  xmlAttr *attribute = currentNode->properties;
  if (attribute)
    {
      NSMutableArray *attributeArray = [NSMutableArray array];
      while (attribute)
        {
          NSMutableDictionary *attributeDictionary = [NSMutableDictionary dictionary];
          NSString *attributeName =
            [NSString stringWithCString:(const char *)attribute->name encoding:NSUTF8StringEncoding];
          if (attributeName)
            {
              [attributeDictionary setObject:attributeName forKey:@"attributeName"];
            }

          if (attribute->children)
            {
              NSDictionary *childDictionary = DictionaryForNode(attribute->children, attributeDictionary);
              if (childDictionary)
                {
                  [attributeDictionary setObject:childDictionary forKey:@"attributeContent"];
                }
//				NSString *attriValue = [NSString stringWithCString:(const char *)attribute->children->content encoding:NSUTF8StringEncoding];
//				NSLog(@"value=%@", attriValue);
//				if (attriValue)
//				{
//					[attributeDictionary setObject:attriValue forKey:@"attributeContent"];
//				}
            }

          if ([attributeDictionary count] > 0)
            {
              [attributeArray addObject:attributeDictionary];
            }
          attribute = attribute->next;
        }

      if ([attributeArray count] > 0)
        {
          [resultForNode setObject:attributeArray forKey:@"nodeAttributeArray"];
        }
    }

  xmlNodePtr childNode = currentNode->children;
  if (childNode)
    {
      NSMutableArray *childContentArray = [NSMutableArray array];
      while (childNode)
        {
          NSDictionary *childDictionary = DictionaryForNode(childNode, resultForNode);
          if (childDictionary)
            {
              [childContentArray addObject:childDictionary];
            }
          childNode = childNode->next;
        }
      if ([childContentArray count] > 0)
        {
          [resultForNode setObject:childContentArray forKey:@"nodeChildArray"];
        }
    }

  return resultForNode;
}

NSDictionary *DictionaryForNode2(xmlNodePtr currentNode, NSMutableDictionary *parentResult)
{
	NSMutableDictionary *resultForNode = [NSMutableDictionary dictionary];
	
	if (currentNode->name)
    {
		NSString *currentNodeContent =
        [NSString stringWithCString:(const char *)currentNode->name encoding:NSUTF8StringEncoding];
		[resultForNode setObject:currentNodeContent forKey:@"nodeName"];
    }
	
	if (currentNode->content)
	{
		NSString *currentNodeContent = [NSString stringWithCString:(const char *)currentNode->content encoding:NSUTF8StringEncoding];
		
		if (currentNode->type == XML_TEXT_NODE)
		{
			if (currentNode->parent->type == XML_ELEMENT_NODE)
			{
				[parentResult setObject:currentNodeContent forKey:@"nodeContent"];
				return nil;
			}
			
			if (currentNode->parent->type == XML_ATTRIBUTE_NODE)
			{
				[parentResult
				 setObject:
				 [currentNodeContent
				  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
				 forKey:@"attributeContent"];
				return nil;

			}
		}
	}
	

	
	xmlAttr *attribute = currentNode->properties;
	if (attribute)
    {
		NSMutableArray *attributeArray = [NSMutableArray array];
		while (attribute)
        {
			NSMutableDictionary *attributeDictionary = [NSMutableDictionary dictionary];
			NSString *attributeName =
            [NSString stringWithCString:(const char *)attribute->name encoding:NSUTF8StringEncoding];
			if (attributeName)
            {
				[attributeDictionary setObject:attributeName forKey:@"attributeName"];
            }
			
			if (attribute->children)
            {
				NSDictionary *childDictionary = DictionaryForNode2(attribute->children, attributeDictionary);
				if (childDictionary)
                {
					[attributeDictionary setObject:childDictionary forKey:@"attributeContent"];
                }
            }
			
			if ([attributeDictionary count] > 0)
            {
				[attributeArray addObject:attributeDictionary];
            }
			attribute = attribute->next;
        }
		
		if ([attributeArray count] > 0)
        {
			[resultForNode setObject:attributeArray forKey:@"nodeAttributeArray"];
        }
    }
	
	xmlNodePtr childNode = currentNode->children;
	if (childNode)
    {
		NSMutableArray *childContentArray = [NSMutableArray array];
		while (childNode)
        {
			NSDictionary *childDictionary = DictionaryForNode2(childNode, resultForNode);
			if (childDictionary)
            {
				[childContentArray addObject:childDictionary];
            }
			childNode = childNode->next;
        }
		if ([childContentArray count] > 0)
        {
			[resultForNode setObject:childContentArray forKey:@"nodeChildArray"];
        }
    }
	
	return resultForNode;
}

NSArray *PerformXPathQuery(xmlDocPtr doc, NSString *query)
{
  xmlXPathContextPtr xpathCtx;
  xmlXPathObjectPtr xpathObj;

  /* Create xpath evaluation context */
  xpathCtx = xmlXPathNewContext(doc);
  if(xpathCtx == NULL)
    {
      NSLog(@"Unable to create XPath context.");
	  /* Cleanup */
	  xmlXPathFreeObject(xpathObj);
	  xmlXPathFreeContext(xpathCtx);
      return nil;
    }

  /* Evaluate xpath expression */
  xpathObj = xmlXPathEvalExpression((xmlChar *)[query cStringUsingEncoding:NSUTF8StringEncoding], xpathCtx);
  if(xpathObj == NULL) {
    NSLog(@"Unable to evaluate XPath.");
    return nil;
  }

  xmlNodeSetPtr nodes = xpathObj->nodesetval;
  if (!nodes)
    {
      NSLog(@"Nodes was nil.");
      return nil;
    }
//	xmlChar *str = xmlNodeGetContent(nodes->nodeTab[0]);
//	NSString *subStr = [NSString stringWithCString:(const char *)str encoding:NSUTF8StringEncoding];
//	
//	NSLog(@"subStr=%@", subStr);
  NSMutableArray *resultNodes = [NSMutableArray array];
  for (NSInteger i = 0; i < nodes->nodeNr; i++)
    {
      NSDictionary *nodeDictionary = DictionaryForNode2(nodes->nodeTab[i], nil);
      if (nodeDictionary)
        {
          [resultNodes addObject:nodeDictionary];
        }
    }

  /* Cleanup */
  xmlXPathFreeObject(xpathObj);
  xmlXPathFreeContext(xpathCtx);

  return resultNodes;
}

NSString *PerformXPathSub(xmlDocPtr doc, NSString *query)
{
	xmlXPathContextPtr xpathCtx;
	xmlXPathObjectPtr xpathObj;
	
	/* Create xpath evaluation context */
	xpathCtx = xmlXPathNewContext(doc);
	if(xpathCtx == NULL)
    {
		NSLog(@"Unable to create XPath context.");
		/* Cleanup */
		xmlXPathFreeObject(xpathObj);
		xmlXPathFreeContext(xpathCtx);
		return nil;
    }
	
	/* Evaluate xpath expression */
	xpathObj = xmlXPathEvalExpression((xmlChar *)[query cStringUsingEncoding:NSUTF8StringEncoding], xpathCtx);
	if(xpathObj == NULL) {
		NSLog(@"Unable to evaluate XPath.");
		return nil;
	}
	
	xmlNodeSetPtr nodes = xpathObj->nodesetval;
	if (!nodes)
    {
		NSLog(@"Nodes was nil.");
		return nil;
    }
	
	xmlChar *str = xmlNodeGetContent(nodes->nodeTab[0]);
	NSString *subStr = [NSString stringWithCString:(const char *)str encoding:NSUTF8StringEncoding];
	xmlFree(str);
	//NSLog(@"subStr=%@", subStr);
	
	return [[subStr retain] autorelease];
}

NSArray *PerformHTMLXPathQuery(NSData *document, NSString *query)
{
  xmlDocPtr doc;

  /* Load XML document */
  doc = htmlReadMemory([document bytes], [document length], "", NULL, HTML_PARSE_NOWARNING | HTML_PARSE_NOERROR);

  if (doc == NULL)
    {
      NSLog(@"Unable to parse.");
      return nil;
    }

  NSArray *result = PerformXPathQuery(doc, query);
  xmlFreeDoc(doc);

  return result;
}

NSArray *PerformXMLXPathQuery(NSData *document, NSString *query)
{
  xmlDocPtr doc;

  /* Load XML document */
  doc = xmlReadMemory([document bytes], [document length], "", NULL, XML_PARSE_RECOVER);

  if (doc == NULL)
    {
      NSLog(@"Unable to parse.");
      return nil;
    }

  NSArray *result = PerformXPathQuery(doc, query);
  xmlFreeDoc(doc);

  return result;
}

NSString *PerformSubHTMLPath(NSData *document, NSString *query)
{
	xmlDocPtr doc;
	
	/* Load XML document */
	doc = htmlReadMemory([document bytes], [document length], "", NULL, HTML_PARSE_NOWARNING | HTML_PARSE_NOERROR);
	
	if (doc == NULL)
    {
		NSLog(@"Unable to parse.");
		return nil;
    }
	
	NSString *result = PerformXPathSub(doc, query);
	xmlFreeDoc(doc);
	
	return result;
}
