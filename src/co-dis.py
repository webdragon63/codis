# Reliable and Simplified Content Discovery Tool
# Author: webdragon63
import argparse
import requests
from concurrent.futures import ThreadPoolExecutor, as_completed

# Function to send requests and discover content
def discover_content(url, path, methods, headers, verbose):
    results = []
    for method in methods:
        try:
            response = requests.request(method, f"{url}/{path}", headers=headers, timeout=10)
            if response.status_code != 404:
                results.append(f"[FOUND] {url}/{path} ({method} - {response.status_code})")
            elif verbose:
                results.append(f"[DEBUG] {url}/{path} ({method} - 404)")
        except requests.exceptions.RequestException as e:
            if verbose:
                results.append(f"[ERROR] {url}/{path} ({method}) - {e}")
    return results

# Main function to handle user input and execute discovery
def main():
    parser = argparse.ArgumentParser(description="Content Discovery Tool")
    parser.add_argument("-u", "--url", required=True, help="Target URL (e.g., https://example.com)")
    parser.add_argument("-w", "--wordlist", required=True, help="Path to wordlist file")
    parser.add_argument("-m", "--methods", default="GET,HEAD", help="HTTP methods to use (comma-separated, default: GET,HEAD)")
    parser.add_argument("-H", "--headers", action="append", help="Custom headers (e.g., 'Authorization: Bearer token')")
    parser.add_argument("-o", "--output", help="File to save results")
    parser.add_argument("-t", "--threads", type=int, default=5, help="Number of parallel threads (default: 5)")
    parser.add_argument("-v", "--verbose", action="store_true", help="Enable verbose mode")
    args = parser.parse_args()

    # Validate inputs
    url = args.url.rstrip('/')
    try:
        with open(args.wordlist, "r") as f:
            wordlist = [line.strip() for line in f if line.strip()]
    except FileNotFoundError:
        print(f"[ERROR] Wordlist file not found: {args.wordlist}")
        return

    methods = args.methods.split(',')
    headers = {}
    if args.headers:
        for header in args.headers:
            key, value = header.split(':', 1)
            headers[key.strip()] = value.strip()

    # Run content discovery
    print(f"[INFO] Starting content discovery on {url} using {args.wordlist}...")
    if args.output:
        print(f"[INFO] Results will be saved to {args.output}")

    all_results = []

    with ThreadPoolExecutor(max_workers=args.threads) as executor:
        futures = {
            executor.submit(discover_content, url, path, methods, headers, args.verbose): path
            for path in wordlist
        }

        for future in as_completed(futures):
            path = futures[future]
            try:
                results = future.result()
                all_results.extend(results)
                for result in results:
                    print(result)
            except Exception as e:
                if args.verbose:
                    print(f"[ERROR] Exception occurred for {path}: {e}")

    # Save results if output file is specified
    if args.output:
        with open(args.output, "w") as f:
            f.write("\n".join(all_results))

    print("[INFO] Discovery complete.")

if __name__ == "__main__":
    main()

