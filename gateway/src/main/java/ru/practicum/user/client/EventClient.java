package ru.practicum.user.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.util.DefaultUriBuilderFactory;
import ru.practicum.baseClient.BaseClient;
import ru.practicum.user.dto.NewEventDto;
import ru.practicum.user.dto.UpdateEventRequestDto;

import java.util.Map;

@Service
public class EventClient extends BaseClient {

    private static final String API_PREFIX = "/users";

    @Autowired
    public EventClient(@Value("${exploreWithMe-server.url}") String serverUrl, RestTemplateBuilder builder) {
        super(
                builder
                        .uriTemplateHandler(new DefaultUriBuilderFactory(serverUrl + API_PREFIX))
                        .requestFactory(HttpComponentsClientHttpRequestFactory::new)
                        .build()
        );
    }

    public ResponseEntity<Object> getEventsByUserId(long userId, Integer from, Integer size) {
        Map<String, Object> parameters = Map.of(
                "from", from,
                "size", size
        );
        return get("/" + userId + "/events?from={from}&size={size}", userId, parameters);
    }

    public ResponseEntity<Object> createNewEvent(long userId, NewEventDto eventDto) {
        return post("/" + userId + "/events", eventDto);
    }

    public ResponseEntity<Object> updateEvent(long userId, UpdateEventRequestDto eventDto) {
        return patch("/" + userId + "/events", eventDto);
    }

    public ResponseEntity<Object> getEventByUserIdAndEventId(long userId, long eventId) {
        return get("/" + userId + "/events/" + eventId);
    }

    public ResponseEntity<Object> cancelEvent(long userId, long eventId) {
        return patch("/" + userId + "/events/" + eventId);
    }
}

