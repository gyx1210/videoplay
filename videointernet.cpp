#include "videointernet.h"
#include<curl/curl.h>
#include <iostream>
static size_t downloadCallback(void *buffer, size_t sz, size_t nmemb, void *writer)
{
    std::string* psResponse = (std::string*) writer;
    size_t size = sz * nmemb;
    psResponse->append((char*) buffer, size);

    return sz * nmemb;
}
VideoInternet::VideoInternet()
{

}

QString VideoInternet::urllink()
{
    std::string strUrl = "https://v.api.aa1.cn/api/api-fj/";
    std::string strTmpStr;
    CURL *curl = curl_easy_init();
    curl_easy_setopt(curl, CURLOPT_URL, strUrl.c_str());
    curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);
    curl_easy_setopt(curl, CURLOPT_TIMEOUT, 2);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, downloadCallback);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &strTmpStr);
    CURLcode res = curl_easy_perform(curl);
    curl_easy_cleanup(curl);
    std::string strRsp;
    if (res != CURLE_OK)
    {
        strRsp = "error";
    }
    else
    {
        strRsp = strTmpStr;
    }
    std::string temp=strRsp;
    std::string temp1="src=";
    int star=temp.find(temp1);
    temp=temp.substr(star+temp1.length()+1);
    int end=temp.find("\"");
    temp="https:"+temp.substr(0,end);
    if(temp.length()<10)
        urllink();
    else
        link= QString::fromLocal8Bit(temp.c_str());
    return link;
}
