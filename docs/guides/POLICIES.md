# 📑 Security Policies Configuration in Microsoft Intune

This document provides a guide to configuring security policies within **Microsoft Intune**. These policies are essential for managing the security of devices and applications in an enterprise environment.

## 🔒 Types of Security Policies

### 1. **Password Policies**

- Set requirements for device passwords, including complexity, length, and expiration time.

- Enforce password history and retry limits.

### 2. **Device Encryption**

- Ensure that devices are encrypted to protect data at rest.

- Use BitLocker (Windows) or FileVault (macOS) for encryption.

### 3. **Compliance Policies**

- Define the minimum security requirements that devices must meet to access corporate resources.

- Policies include OS version, encryption status, and malware protection.

### 4. **App Protection Policies**

- Manage how corporate apps interact with personal data and enforce policies like data encryption, data wiping, and conditional access.

### 5. **Security Baselines**

- Use predefined security settings based on Microsoft's security recommendations.

- Baselines are available for platforms like Windows, iOS, and Android.

---

## 🛠️ How to Configure Security Policies

### Step 1: Create a New Policy

1. Go to **Microsoft Endpoint Manager Admin Center**.

2. Navigate to **Devices** > **Configuration profiles**.

3. Select **Create profile** and choose the platform (e.g., Windows, iOS).

4. Select a policy type, such as **Device restrictions**, **Compliance policy**, or **App protection policy**.

### Step 2: Define the Security Settings

- For **password policies**, configure the minimum password length, complexity, and expiration.

- For **device encryption**, enable the **BitLocker** encryption option for Windows devices.

### Step 3: Assign the Policy

1. Once the policy is created, assign it to groups of devices or users.

2. Choose **Assignments** and select the target groups.

### Step 4: Monitor and Update Policies

- Periodically review and update security policies to ensure that they meet the latest security standards.

- Use the **Monitor** section in the Intune Admin Center to track the status of policy compliance.

---

## ✅ Best Practices for Security Policies

- **Regularly review compliance policies** to ensure they align with your organization's evolving security needs.
- **Test policies** on a small group of devices before a full deployment.
- **Enforce multi-factor authentication** for sensitive applications to enhance security.
