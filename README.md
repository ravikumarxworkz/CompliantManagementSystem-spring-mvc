# ResolveX - Complaint Management System (Web Application)

## Project Overview
**ResolveX** is a robust web application developed to streamline complaint management across various sectors. With a modular design, it offers four distinct modules: **User**, **Admin**, **Department**, and **Employee**. The system enables efficient complaint lodging, tracking, assignment, and resolution while ensuring secure, OTP-based processes and real-time monitoring.

## Features

### User Module
- **User Registration**: Includes email validation and OTP verification for secure account creation.
- **Profile Management**: Allows users to manage and update their profile information.
- **Complaint Lodging**: Simple form for users to submit complaints with relevant details.
- **Complaint Tracking**: Users can track the real-time status and progress of their complaints.
- **OTP-Based Complaint Closure**: Users verify complaint closure with OTP for added security.

### Admin Module
- **Dashboard**: Provides real-time statistics for complaints, departments, and employees.
- **Complaint Management**: Allows admins to assign and update complaints lodged by users.
- **System Management**: Admins can manage departments and employees within the system, streamlining complaint workflows.

### Department Module
- **Complaint Assignment**: Departments can assign complaints to employees based on expertise.
- **Performance Monitoring**: Departments can track the status of complaints and monitor employee performance for effective resolution management.

### Employee Module
- **Complaint Handling**: Employees are responsible for resolving assigned complaints.
- **Secure Resolution Verification**: OTP-based verification to confirm complaint resolutions.
- **Profile Management**: Employees can update and manage their profile information.

## Technologies Used
- **Backend**: Java (JSP/Servlets)
- **Frontend**: HTML, CSS, JavaScript, Bootstrap, FontAwesome
- **Database**: MySQL
- **Version Control**: Git

## Key Highlights
- **Modular System**: Each module (User, Admin, Department, Employee) has defined responsibilities, enabling efficient management.
- **User-Centric Design**: Simple, intuitive interface for complaint lodging, tracking, and resolution.
- **OTP Verification**: Enhanced security with OTP verification for complaint closure.
- **Admin Control**: Admin dashboard offers complaint management and detailed statistics for effective oversight.
- **Department Efficiency**: Optimized workflows for task assignment and performance monitoring.

## Installation and Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/ravikumarxworkz/CompliantManagementSystem-spring-mvc.git
   ```

2. **Configure Database**:
   - Import the provided SQL script to initialize the MySQL database.
   - Update connection details in `dbconfig.properties` with your database configuration.

3. **Build and Deploy**:
   - Use Maven to build the project.
   - Deploy the application on a Tomcat server.
   - Access the application at `http://localhost:8080/ResolveX`.

4. **Admin Setup**:
   - Log in using the default admin credentials to set up departments and employees.

## Advanced Features
- **Role-Based Access Control**: Future plans for more granular permissions based on roles to enhance security.
- **Mobile Responsiveness**: Optimizations planned for a better user experience on mobile devices.
- **Enhanced Notification System**: Plans to implement email/SMS notifications to inform users about complaint status updates.
- **Reporting and Analytics**: Future enhancement to provide in-depth reports on complaint trends and resolution metrics.

## Future Enhancements
- **Push Notifications**: In-app notifications for real-time updates on complaint statuses.
- **Automated Workflows**: Automation of complaint assignment based on department workload and employee performance.
- **Feedback System**: Users can rate and provide feedback on complaint resolution to improve service quality.
- **Integration with Third-Party Services**: SMS or WhatsApp API integration for enhanced communication with users.

## GitHub Project Link
- [GitHub Repository for ResolveX](https://github.com/ravikumarxworkz/CompliantManagementSystem-spring-mvc.git)

## Contributing
We welcome contributions from the community! Please refer to our `CONTRIBUTING.md` file for details on how to get started.

## License
This project is licensed under the **MIT License**. Please see the `LICENSE` file for more information.
