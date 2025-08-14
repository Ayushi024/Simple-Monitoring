
# Simple-Monitoring

**Basic monitoring dashboard using Netdata**
**Project URL:** [https://roadmap.sh/projects/simple-monitoring-dashboard](https://roadmap.sh/projects/simple-monitoring-dashboard)

This project demonstrates setting up a **real-time monitoring dashboard** using Netdata on a Windows system through WSL2 Ubuntu.
Netdata allows you to monitor system metrics such as **CPU, memory, disk I/O**, and create **custom alerts**.
Automation scripts are included to **install, test, and clean up Netdata**, helping understand **DevOps practices and CI/CD workflows**.

---

## **Prerequisites**

* Windows 10/11 with **WSL2 enabled**
* Ubuntu installed in WSL2 (`wsl -d Ubuntu`)
* Basic knowledge of Linux commands

---

## **Project Structure**

```
SIMPLE-MONITORING/
├── setup.sh           # Installs Netdata and starts the service
├── test_dashboard.sh  # Generates CPU load to test metrics
├── cleanup.sh         # Stops Netdata and removes all files
└── README.md          # Project documentation
```

---

## **Step 1 — Install Netdata (`setup.sh`)**

* Create the script:

```bash
nano setup.sh
```

* Paste the following:

```bash
#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl -y
bash <(curl -SsL https://my-netdata.io/kickstart.sh)
sudo nohup netdata >/dev/null 2>&1 &
```

* Make executable and run:

```bash
chmod +x setup.sh
./setup.sh
```

* **Dashboard URL:** [http://localhost:19999](http://localhost:19999)

---

## **Step 2 — Test Dashboard (`test_dashboard.sh`)**

* Create script:

```bash
nano test_dashboard.sh
```

* Paste:

```bash
#!/bin/bash
echo "Generating CPU load..."
sudo apt install stress -y
stress --cpu 2 --timeout 30
```

* Make executable and run:

```bash
chmod +x test_dashboard.sh
./test_dashboard.sh
```

* Observe **CPU, memory, and disk I/O charts** updating on the dashboard.

---

## **Step 3 — Customize Dashboard & Alerts**

### **Change refresh interval**

* Edit config:

```bash
sudo nano /etc/netdata/netdata.conf
```

* Add at the top:

```ini
[global]
    history = 3600       # keeps 1 hour of metrics
    update every = 1     # collect metrics every second
```

### **Set CPU alert**

* Create alert file:

```bash
sudo nano /etc/netdata/health.d/cpu_alert.conf
```

* Paste:

```ini
template: cpu_usage_high
      on: system.cpu
   calc: average -1s
  every: 10s
     warn: $this > 80
     info: CPU usage is above 80%
```

### **Apply changes**

```bash
sudo pkill netdata
sudo netdata &
```

* The dashboard will now trigger alerts if **CPU usage exceeds 80%**.

---

## **Step 4 — Cleanup (`cleanup.sh`)**

* Create script:

```bash
nano cleanup.sh
```

* Paste:

```bash
#!/bin/bash
sudo pkill netdata
sudo apt remove --purge netdata -y
sudo rm -rf /etc/netdata /var/lib/netdata /var/cache/netdata
```

* Make executable and run:

```bash
chmod +x cleanup.sh
./cleanup.sh
```
* This **removes Netdata and all related files**.


## **Step 5 — Workflow Summary**

* Open **WSL Ubuntu terminal**.
* Run `setup.sh` → Netdata installed and running.
* Access dashboard → [http://localhost:19999](http://localhost:19999)
* Run `test_dashboard.sh` → check real-time metric updates.
* Customize **dashboard & alerts** as needed.
* Run `cleanup.sh` → remove Netdata when done.

