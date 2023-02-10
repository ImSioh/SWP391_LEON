package dto;

import java.sql.Timestamp;
import java.util.UUID;

public class Notification {

    private UUID notificationId;
    private UUID accountId;
    private UUID classId;
    private String title;
    private String redirectUrl;
    private String content;
    private Timestamp createTime;

    public Notification(UUID notificationId, UUID accountId, UUID classId, String title, String redirectUrl, String content, Timestamp createTime) {
        this.notificationId = notificationId;
        this.accountId = accountId;
        this.classId = classId;
        this.title = title;
        this.redirectUrl = redirectUrl;
        this.content = content;
        this.createTime = createTime;
    }

    public UUID getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(UUID notificationId) {
        this.notificationId = notificationId;
    }

    public UUID getAccountId() {
        return accountId;
    }

    public void setAccountId(UUID accountId) {
        this.accountId = accountId;
    }

    public UUID getClassId() {
        return classId;
    }

    public void setClassId(UUID classId) {
        this.classId = classId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getRedirectUrl() {
        return redirectUrl;
    }

    public void setRedirectUrl(String redirectUrl) {
        this.redirectUrl = redirectUrl;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "Notification(" + String.join(", ", new String[]{
            notificationId.toString(),
            accountId.toString(),
            classId.toString(),
            title,
            redirectUrl,
            content,
            createTime.toString()
        }) + ")";
    }

    @Override
    public boolean equals(Object obj) {
        Notification notification = (Notification) obj;
        return notification.notificationId.equals(this.notificationId);
    }

}
