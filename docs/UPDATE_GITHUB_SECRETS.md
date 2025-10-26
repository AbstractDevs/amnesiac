# Update GitHub Repository Secrets

Navigate to your GitHub repository: https://github.com/AbstractDevs/amnesiac

## Steps to Update Secrets:

1. **Go to Settings** → **Secrets and variables** → **Actions**

2. **Update or create these secrets:**

   | Secret Name | Value |
   |-------------|-------|
   | `PUBLIC_API_URL` | `https://64.225.49.223` |
   | `PUBLIC_API_BASE_URL` | `https://64.225.49.223/api` |

3. **Click "Update secret"** for each one

## Trigger New Deployment:

After updating the secrets, trigger a new deployment by either:

### Option A: Manual Workflow Trigger
1. Go to **Actions** tab
2. Select **Deploy Web App to GitHub Pages**
3. Click **Run workflow** → **Run workflow**

### Option B: Push a Small Change
Create a small commit to trigger automatic deployment:

```bash
# Make a small change to trigger deployment
echo "# Updated $(date)" >> apps/web/README.md
git add apps/web/README.md
git commit -m "trigger: update API URLs to HTTPS"
git push origin main
```

## Verify Deployment:

After deployment completes (usually 2-3 minutes):

1. **Clear browser cache** (Ctrl+Shift+R or Cmd+Shift+R)
2. **Visit**: https://abstractdevs.github.io/amnesiac/admin
3. **Check browser console** for any remaining errors

The web app should now connect to your HTTPS API successfully!