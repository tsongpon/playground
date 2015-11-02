package com.abctechthailand.playground.component;

import io.searchbox.client.JestClient;
import io.searchbox.client.JestClientFactory;
import io.searchbox.client.config.HttpClientConfig;
import io.searchbox.core.Search;
import io.searchbox.core.SearchResult;
import io.searchbox.indices.CreateIndex;
import io.searchbox.indices.DeleteIndex;
import io.searchbox.indices.IndicesExists;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.builder.SearchSourceBuilder;


/**
 *
 */
public class ElasticsearchClient {

    public static void main(String [] args) throws Exception{

        JestClientFactory factory = new JestClientFactory();
        factory.setHttpClientConfig(new HttpClientConfig.Builder("http://bearing.dev.abctech-thailand.com/es/")
                .multiThreaded(true)
                .build());
        JestClient client = factory.getObject();

        boolean indexExists = client.execute(new IndicesExists.Builder("jug").build()).isSucceeded();
        if (indexExists) {
            client.execute(new DeleteIndex.Builder("jug").build());
        }
        client.execute(new CreateIndex.Builder("jug").build());

        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
        searchSourceBuilder.query(
                QueryBuilders.boolQuery()
                        .should(QueryBuilders.matchQuery("title", "sentrum"))
        );

        System.out.print(searchSourceBuilder.toString());

        Search sarch = new Search.Builder(searchSourceBuilder.toString())
                .addIndex("classified")
                        //ignore_unavailable parameter improves multi-index search.
                        //The search won't fail as long as one of the supplied indexes answers.
                .setParameter("ignore_unavailable", true)
                .build();
        SearchResult result = client.execute(sarch);

        System.out.println(result.getJsonObject().toString());
    }
}
