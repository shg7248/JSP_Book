package com.movie.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Song {
	public static void main(String[] args) {
		
		LocalDateTime dateTime = LocalDateTime.now();
		dateTime.format(DateTimeFormatter.ofPattern("yyyyMMddhhmmss"));
	}
}
