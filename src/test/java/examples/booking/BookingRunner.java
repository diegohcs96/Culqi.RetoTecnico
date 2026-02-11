package examples.booking;

import com.intuit.karate.junit5.Karate;

public class BookingRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("booking").relativeTo(getClass());
    }
}
