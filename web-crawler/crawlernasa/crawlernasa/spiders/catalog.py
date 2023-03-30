import scrapy

from crawlernasa.items import CatalogItem


class CatalogSpider(scrapy.Spider):
    name = 'catalog'
    allowed_domains = ['eclipse.gsfc.nasa.gov']
    start_urls = ['http://eclipse.gsfc.nasa.gov/']
    custom_settings = {"FEEDS":{"results2.json":{"format":"json"}}}


    def start_requests(self):
        yield scrapy.Request('https://eclipse.gsfc.nasa.gov/LEcat5/LE2001-2100.html', self.parse)

    def parse(self, response):
        """
        for pre in response.xpath('//pre[re:match(text(), "\d{4}\s+(Jan(uary)?|Feb(ruary)?|Mar(ch)?|Apr(il)?|May|Jun(e)?|Jul(y)?|Aug(ust)?|Sep(tember)?|Oct(ober)?|Nov(ember)?|Dec(ember)?)\s+\d{1,2}\s+(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d):)?([0-5]?\d)")]').getall():
            yield CatalogItem(content=pre)

        for pre in response.xpath('//pre/text()').extract("\d{4}\s+(Jan(uary)?|Feb(ruary)?|Mar(ch)?|Apr(il)?|May|Jun(e)?|Jul(y)?|Aug(ust)?|Sep(tember)?|Oct(ober)?|Nov(ember)?|Dec(ember)?)\s+\d{1,2}\s+(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d):)?([0-5]?\d)").getall():
            yield CatalogItem(content=pre)

        """
        data = []
        for pre in response.xpath('//pre/text()').getall():
            data.append(pre)

        yield CatalogItem(content=data)
