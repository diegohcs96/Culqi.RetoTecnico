package examples.auth;

import com.intuit.karate.junit5.Karate;

public class AuthRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("auth").relativeTo(getClass());
    }
}
