using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

public class Email
{
    public static void SendEmail(string toEmail, string name, string msg, string date=null, string time=null, string persons=null, string contact=null)
    {
        MailMessage mail = new MailMessage();
        mail.From = new MailAddress("cyberwolves85@gmail.com", "Cravify Grocery Support");     //"cravify@gmail.com", "Cravify Grocery Support"
        mail.To.Add(toEmail);

        switch (msg)
        {
            case "Welcome":
                mail.Subject = "Welcome to Cravify!!";
                mail.Body = $"Hi {name}, \n\nWelcome to Cravify! \n\nYour account has been created successfully. " +
                             "You can now browse our menu & place delicious food right from the comfort of your home. " +
                             "\n\nHappy Ordering! \n\n\n\n- Team Cravify";        //Best Regards, \nCravify Support Team
                break;
            case "Update Details":
                mail.Subject = "Cravify Profile Details Updated!!";
                mail.Body = $"Hi {name}, \n\nWe wanted to let you know that your profile details on Cravify have been " +
                             "successfully updated. \n\nIf you did not make this change or if you believe your account has " +
                             "been accessed without your permission, please contact our Support Team immediately. " +
                             "\n\nThank you for choosing Cravify! \n\n\n\n- Team Cravify";
                break;
            case "Placed":
                mail.Subject = "Cravify Order Placed!!";
                mail.Body = $"Hi {name}, \n\nThank you for placing order with Cravify! \n\nYour order has been successfully " +
                             "received. We've started preparing your food & it wil be on its way soon. \n\nWe'll notify you " +
                             "once your order is Out for Delivery. \n\nBon Appetit! \n\n\n\n- Team Cravify";
                break;
            case "Delayed":
                mail.Subject = "Cravify Order Delayed!!";     //Update on your Cravify Order - Delayed
                mail.Body = $"Hi {name}, \n\nWe regret to inform you that your recent order with Cravify has been delayed due " +
                             "to unforseen circumstances. \n\nWe truely apologize for the incovenience caused. Our team is " +
                             "actively working to get your order to you as soon as possible We appreciate your patience & " +
                             "understanding. \n\nIf you have any questions, fell free to reach out to our Support Team. " +
                             "\n\nThank you for choosing Cravify! \n\n\n\n- Team Cravify";
                break;
            case "Out for Delivery":
                mail.Subject = "Cravify Order Out for Delivery!!";
                mail.Body = $"Hi {name}, \n\nGreat News! Your order is now Out for Delivery. \n\nOur delivery partner is on the " +
                             "way & will reach your location shortly. \n\nThank you for ordering from Cravify! \nEnjoy your meal! " +
                             "\n\n\n\n- Team Cravify";
                break;
            case "Delivered":
                mail.Subject = "Cravify Order Delivered!!";
                mail.Body = $"Hi {name}, \n\nYour order has been delivered successfully! \n\nWe hope you enjoyed your meal. If " +
                             "you liked our service, please leave a review & come back soon for more tasty treats. \n\nThank you " +
                             "for choosing Cravify! \n\n\n\n- Team Cravify";
                break;
            case "New Request":
                mail.Subject = "Cravify New Reservation Request!!";
                mail.Body = $"Hi {name}, \n\nWe have received a new reservation request from your end. Please review the details " +
                            $"given below: \n\nCustomer Name: {name} \nDate & Time: {date} {time} \nNo. of Persons: {persons} \n" +
                            $"Contact No.: {contact} \n\nKindly confirm or decline this request from your dashboard at your " +
                             "earliest convenience. \n\nThank you for choosing Cravify! \n\n\n\n- Team Cravify";
                break;
            case "Declined":
                mail.Subject = "Cravify Reservation Declined!!";
                mail.Body = $"Hi {name}, \n\nWe're sorry to inform you that your recent reservation request with Cravify has been " +
                             "declined. \n\nThis may be due to unavailabilty or scheduling conflicts. \nYou can try  try booking " +
                             "for a different time or explore other restaurants on   Cravify. \n\nWe apologize for the " +
                             "inconvenience and thank you for your understanding. \n\n\n\n- Team Cravify";
                break;
            case "Confirmed":
                mail.Subject = "Cravify Order Delivered!!";
                mail.Body = $"Hi {name}, \n\nGood news! Your reservation Cravify has ben successfully confirmed. \n\nHere are the " +
                            $"details: \nCustomer Name: {name} \nDate & Time: {date} {time} \nNo. of Persons: {persons} \n" +
                            $"Contact No.: {contact} \n\nPlease arrive on time and present this email at Cravify if needed. " +
                             "\n\nThank you for choosing Cravify! \n\n\n\n- Team Cravify";
                break;
        }

        mail.IsBodyHtml = false;
        SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
        smtp.UseDefaultCredentials = false;
        smtp.Credentials = new NetworkCredential("cyberwolves85@gmail.com", "psdaycolzlmhxntz");
        smtp.EnableSsl = true;
        //smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
        try
        {
            smtp.Send(mail);
        }
        catch (Exception ex)
        {
            Console.WriteLine("Email Sending Failed: " + ex.Message);
        }
    }
}