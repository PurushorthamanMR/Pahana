/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.patterns;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author pruso
 */
public class ObserverDP {
    
    public interface Subject {
        void registerObserver(Observer observer);
        void removeObserver(Observer observer);
        void notifyObservers(String message, String eventType);
    }
    
    public interface Observer {
        void update(String message, String eventType);
    }
    
    public static class SystemEventManager implements Subject {
        private List<Observer> observers = new ArrayList<>();
        private static SystemEventManager instance;
        
        private SystemEventManager() {}
        
        public static SystemEventManager getInstance() {
            if (instance == null) {
                instance = new SystemEventManager();
            }
            return instance;
        }
        
        @Override
        public void registerObserver(Observer observer) {
            if (!observers.contains(observer)) {
                observers.add(observer);
            }
        }
        
        @Override
        public void removeObserver(Observer observer) {
            observers.remove(observer);
        }
        
        @Override
        public void notifyObservers(String message, String eventType) {
            for (Observer observer : observers) {
                observer.update(message, eventType);
            }
        }
        
        public void logEvent(String message, String eventType) {
            System.out.println("System Event: [" + eventType + "] " + message);
            notifyObservers(message, eventType);
        }
    }
    
    public static class SystemLogger implements Observer {
        @Override
        public void update(String message, String eventType) {
            System.out.println("Logger: [" + eventType + "] " + message);
        }
    }
    
    public static class EmailNotifier implements Observer {
        @Override
        public void update(String message, String eventType) {
            if ("ERROR".equals(eventType) || "CRITICAL".equals(eventType)) {
                System.out.println("Email Notification: [" + eventType + "] " + message);
            }
        }
    }

    public static class AuditTrail implements Observer {
        @Override
        public void update(String message, String eventType) {
            System.out.println("Audit Trail: [" + eventType + "] " + message);
        }
    }
} 