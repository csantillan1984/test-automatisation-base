import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class KarateBasicTest {
    
    @Test
    void testCharactersEndpoint() {
        Results results = Runner.path("classpath:karate-test.feature")
                .tags("~@ignore")
                .parallel(1);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
