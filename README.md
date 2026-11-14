# 🔐 End-to-End DevSecOps Security Pipeline

### Securing a Spring Boot Application Across the CI/CD Lifecycle

This project demonstrates the implementation of an end-to-end DevSecOps pipeline that integrates automated security controls into the software development and deployment lifecycle.

The pipeline is built around a **Spring Boot Student Management application**, using Jenkins for CI/CD orchestration, Docker for containerization, and Kubernetes for deployment.

Its main objective is to **shift security left**, automate vulnerability detection, and integrate security testing and monitoring throughout the application lifecycle.

## 🏗️ Project Architecture

The workflow follows four main DevSecOps phases:

**Development → Acceptance → Production → Operations**

```text
Developer
   |
   v
Git Pre-Commit
   |-- ThoughtWorks Talisman
   |
   v
GitHub Repository
   |
   v
Jenkins CI/CD Pipeline
   |
   |-- SonarQube (SAST)
   |-- OWASP Dependency-Check (SCA)
   |-- Maven Build
   |-- Docker Image Build & Push
   |
   v
Kubernetes Deployment
   |
   |-- Spring Boot Application
   |-- MySQL Database
   |
   v
Security Validation
   |-- Nmap Network Scanning
   |-- OWASP ZAP Baseline Scan
   |
   v
Monitoring
   |-- Prometheus
   |-- Grafana
   |
   v
Jenkins Email Notifications
```

## 🛠️ Technology Stack

| Category | Tools |
|---|---|
| Application | Java, Spring Boot, Maven, MySQL |
| Version Control | Git, GitHub |
| CI/CD | Jenkins |
| Secret Detection | ThoughtWorks Talisman |
| SAST | SonarQube |
| SCA | OWASP Dependency-Check |
| Containerization | Docker, BuildKit |
| Orchestration | Kubernetes (Docker Desktop / kind) |
| Network Security | Nmap |
| Dynamic Security Testing | OWASP ZAP |
| Monitoring | Prometheus, Grafana |
| Notifications | Jenkins Email Extension |

## 🔍 Security Integration Across the DevSecOps Lifecycle

### 1. Development Phase — Shift-Left Security

Security controls are introduced early in the development lifecycle to detect potential vulnerabilities before deployment.

**Pre-Commit Security — ThoughtWorks Talisman**

- Integrated Git pre-commit hooks to detect potentially sensitive information.
- Tested secret detection using simulated AWS credentials.
- Helps prevent accidental exposure of credentials in source code.

**Static Application Security Testing — SonarQube**

- Integrated automated static code analysis into Jenkins.
- Analyzed source code for security and quality issues.
- Used the SonarQube dashboard to review identified findings.

**Software Composition Analysis — OWASP Dependency-Check**

- Scanned Maven dependencies for known vulnerabilities.
- Generated HTML vulnerability reports.
- Archived scan results as Jenkins build artifacts.

### 2. Acceptance Phase — Network Security Testing

**Nmap**

- Automated network scans as part of the Jenkins pipeline.
- Checked the accessibility of application network services.
- Validated exposure of the Spring Boot application port.
- Archived scan outputs for traceability.

### 3. Production Phase — Dynamic Security Testing

**OWASP ZAP Baseline**

- Integrated automated baseline security scanning into Jenkins.
- Performed passive security checks against the deployed application.
- Generated HTML reports and scan logs.
- Identified security configuration findings, including missing HTTP security headers.

The baseline scan provides an initial assessment of application security but does not replace comprehensive penetration testing.

### 4. Operations Phase — Monitoring and Observability

**Prometheus & Grafana**

Implemented monitoring for the deployed application, including:

- HTTP request rate
- Spring Boot CPU usage
- JVM heap memory usage
- MySQL active connections

Prometheus collects application metrics, while Grafana provides dashboards for visualizing application behavior and resource utilization.

### 5. Post-Build Actions — Automated Notifications

Configured Jenkins email notifications to report pipeline execution status.

Notifications include the build result and a direct link to the corresponding Jenkins execution.

## ⚙️ CI/CD Pipeline Stages

The Jenkins pipeline includes the following automated stages:

1. Source code checkout
2. SonarQube static analysis
3. OWASP Dependency-Check
4. Maven build and artifact verification
5. Docker image build and push
6. Kubernetes deployment
7. Nmap security scan
8. OWASP ZAP baseline scan
9. Report archiving and email notifications

Security scan reports are preserved as build artifacts for inspection and traceability.

## 📊 Project Results

The project demonstrates:

- Automated security checks integrated into CI/CD.
- Early detection of potential secrets, vulnerable dependencies, and code issues.
- Containerized application deployment using Kubernetes.
- Network and dynamic security testing.
- Centralized vulnerability reports.
- Application monitoring and automated pipeline notifications.

The project was tested in a local lab environment. Security findings identified by the scanners remain subject to manual review and remediation.

## 🚀 Future Improvements

- Add automated security quality gates to enforce deployment policies.
- Integrate container image vulnerability scanning with Trivy.
- Implement Kubernetes configuration scanning.
- Introduce automated authorization and API security tests.
- Expand monitoring with security-focused alerts.
- Improve vulnerability remediation tracking.

## 📌 Project Scope

This repository is an educational DevSecOps implementation developed to demonstrate the integration of security practices into CI/CD pipelines.

It is intended as a practical cybersecurity and DevSecOps portfolio project, not as a production-hardened deployment.

## 👩‍💻 Author

**Oumayma Allani**

Cybersecurity Engineering Student — ESPRIT

Interested in Offensive Security, Application Security, DevSecOps, and Security Automation.
